Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RlvhKzhb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XgukLkMM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7771510E174;
	Fri, 30 Oct 2026 19:20:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB5210E25C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 19:20:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIjGZs3059911
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 19:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/ShQl6WYAmClLLFczEcBV6XknRwLtOiivHG
 hNRMzRi8=; b=RlvhKzhbEf56zUtPosl2dI9UbSsdN7a8c4KbdUEHwlVuOGnDpuj
 Rpr4UoXTo2YZNUQUEQZDBpN1IphR6XgCfxie45mT7eb4iVsU5jKlkEx/4UGkJ3kz
 +CZvIAgFGfUfZT5D/WMby9HVqnlLapKvITGCm3iGgyM5nAO5cycQKDDpvnyM/9u5
 88bdXuDzfpNPNLx0meOgusEVC3WAA9b2GTamzoiVRex4eJwg09gccg9+dNRDewq/
 OO7cs6b8LeT/mXTdSEc9I/+K8C8SxnLUcZqGpHRPq5op2o1ZK44XWGji6L4xzh+8
 pvTEJsJI2SatK3iB8CETxLU8NturAJuYb5g==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0sxg3hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 19:20:17 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6790b1d3bc9so1763884d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793388017; x=1793992817;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ShQl6WYAmClLLFczEcBV6XknRwLtOiivHGhNRMzRi8=;
 b=XgukLkMMxDLFKvwbFmRf5ZzjvizUEIZT31reoHIyGIChQA20G0I+KruPJQRMZArH3h
 DynLJ0X0aJ3Ws/ziAhOqJaxs1TWl61fqZeVfwEUaAg832bx+8LzmkrOz2fp56Ty63SuE
 W5bd/gfe7sF6WDhJ4jLkq79FP3NyXpeqwyYYDMk2x2qWvtvf56hFf7wiSQsjCyCOdewG
 CaRQvDz14n/QjvXu/8ZwXDrRDQ0J71tsSzsTlCtrs1r9eY906MNbXIIqeKhKn6HnFw/n
 iQnMbjuj7+GLHnbKRkQ+KOSwnaf9Vclx90/ZQkhU6Z4twCgh8bGb7eslTNcSyNqrl7j/
 Jttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793388017; x=1793992817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ShQl6WYAmClLLFczEcBV6XknRwLtOiivHGhNRMzRi8=;
 b=JngsMH3S6ZyQtvZsocUzKokkBpdfIJxHOWKamzI1MdBh9E8aFw1csdU53HVr8y6+az
 90s1Ev6f0eBDLxIV2cmecwXcLOe8NLsQFtQFB7xi2sr2AlDU0xh+x+39M7X/fsjHRcW1
 4v91OAGLxHoSs9LJCamZ2Ny9pBQqDkxnXjdVfn12o3s5rRWbXumwWD8AOvbHAHboCVKY
 Su2jGcSJwvIwbpvhAMuDE+sppptS2tf2HWvCewvyYrt5DV62dm29QPRQ/zKk1E3NPvQF
 0mC5Zl6uYA6yUZ3PU7S3eF3+h/hAeZxSoW/FJinSq4pRx1dUeUCPWzh+TigoK+hzeLQq
 nYLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1iDkhh647KGHHXK4lK/jRqFMKpVfWscOmMi+9Qvo3SAk4PRa5ATTMz2eYL0MejiVVP3GwAjoPvbg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK55NkkfoCBCQlow8Xx968pyW2UYKwJLrGVeQaYYk41Rg8PMXYJ
 DTzrXmkF5GLgyH5FiSZhcJVWjEdQKYxM/hiC/Hd4tH+i6FbsyIeyj8ZXKB9nUtCAJZKPREXIrYC
 dM0ccFJFRxr5orIYst0twHqNtJ5C7lDflBDUmgEwpQ1HwrI5LIhirrndfWyf0/StyivbyZ+0=
X-Gm-Gg: AYBFou2RywtH1m5TdT4L2DMElvzuXoJ0z8wujkS6X6SkM2WnSFE1ZtRzMzRq4eVn4PE
 8rcyNzH5wCjEIZiMat6Tf/0+0+qgyVrkliqp/tS9+EZEVG6iez/yoke0eWZ2YODH7doNJCPpvcl
 z8w9x8SdxZ8N4hVj6kmaTZ06xrLmWmyUEVVgJ4oxSsV+6HusffR7IbZ00ATy+LMkgi3/Ro3Lbdd
 NYNQLP8StpoDYLB/NhoHYKxdF4A76raPZHljHQP4VqlpW3DFQdjot+uS1qbTfeMfDMo1IqsuC2d
 LLgdtSoW9jjdVUIH64ZlPQ9anEAvteZZIBWSzSbN/K0/RvB5lACR5fIE6GTPmyWNdid6rptCgre
 GqHi1jff0gOBJAHX50QSany1tldw63DtstbX5rkiaNBBdOG7MMtoykXi5UaWDjq10d5QETRipam
 WWaVd7F90O1QifcJAyPSih6qfhM41UJaLe5w==
X-Received: by 2002:a05:690e:4141:b0:674:e0d2:7e12 with SMTP id
 956f58d0204a3-67ba508d010mr2233316d50.109.1793388016794; 
 Fri, 30 Oct 2026 12:20:16 -0700 (PDT)
X-Received: by 2002:a05:690e:4141:b0:674:e0d2:7e12 with SMTP id
 956f58d0204a3-67ba508d010mr2233286d50.109.1793388016327; 
 Fri, 30 Oct 2026 12:20:16 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b719d2d5sm13185767b3.40.2026.10.30.12.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:20:15 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/a6xx: fall back to MX when gmxc.lvl has no levels
Date: Fri, 30 Oct 2026 15:20:14 -0400
Message-ID: <20261030192014.694393-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3NyBTYWx0ZWRfX5O3Nz+xcJ2Vt
 EYLkDKcIqbN+Hgjky2HZwo0lhKDi/uwAGxLFtMc2wmulGFrIdAkLpRtSY+5V2tnsi0QsgcIkvBJ
 l2UCPLm/elonr9YHvUCZtLT/Hzzqo6exc9UVAtEt/F1jhi3iDa1KD1iTwsBSqu1CiREGcg+T9PG
 r/HB70mXUREfeQrq+Ty5ykvjrfo2Nw6f/qUG1OYGXqOWKdOkRGJN70BbcgFOOlH1avDjEWqOOcR
 ukYSMvcwrgVpyfm55PyBlmONmqCp1e+S8zYrM56soGLXv6RrSe9rHP0giNGFBRM/CjfoHXG+1n0
 tbDJ+lYkELQmhciCgt7NCLhnbwn2mh9Zht0DLqsVxHIvPZYaQLzlPKuVs4BM+di+ZfUPQo9mUWb
 /+u0feoIg19T50S+3BNt5ToNvVUGtgEFzZC6bG4PZSYsQmaG7R32b2LlzUQfus7y1yX5LQ+PE9D
 lP245uhPxuypH08wb5w==
X-Proofpoint-ORIG-GUID: cciQiq3Hpu58e8ULAZ0IJIXrRxDZVyzh
X-Proofpoint-GUID: cciQiq3Hpu58e8ULAZ0IJIXrRxDZVyzh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3NyBTYWx0ZWRfX1PGXVnVeWrxz
 Cej/7qKnYUkuak1puwAEF6gHMrc95s19c+E2qsAu/cSrokpHpGv0h0pWaAULJiuJ+9LYkhc51fe
 lcEGIoHOg47d23/lGNfhc5aGQXVMPQ0=
X-Authority-Analysis: v=2.4 cv=ap0nmiZV c=1 sm=1 tr=0 ts=6ae4edf1 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=0bFHTkV68l4dVm3UfdEA:9 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300077
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Eliza's command DB has a gmxc.lvl entry with an all-zero level table,
though Eliza does not use a GMxC rail. a6xx_gmu_rpmh_votes_init() picks
any gmxc.lvl entry as the GX secondary rail, so building the GX votes
fails, a6xx_gmu_init() ignores the error and the GMU gets a zeroed GX
vote table. On the A722 the first GX_BW_PERF_VOTE HFI then times out
and the GPU stops responding. Before a6xx_gmu_rpmh_read_arc() began
trimming trailing zero levels, every GX vote silently used level 0.

Read gmxc.lvl with a6xx_gmu_rpmh_read_arc(), which rejects an entry
without levels, so the GX votes fall back to mx.lvl.

Fixes: b5269bf0e1ad ("drm/msm/a6xx: Factor out RPMh arc-vote helpers")
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d52..c42e0d4fb946d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1887,15 +1887,16 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	size_t gmxc_lvl_count;
 	const char *sec_id;
 	const u16 *gmxc;
 	int ret;
 
-	gmxc = cmd_db_read_aux_data("gmxc.lvl", NULL);
+	gmxc = a6xx_gmu_rpmh_read_arc("gmxc.lvl", &gmxc_lvl_count);
 	if (gmxc == ERR_PTR(-EPROBE_DEFER))
 		return -EPROBE_DEFER;
 
-	/* If GMxC is present, prefer that as secondary rail for GX votes */
+	/* If GMxC has levels, prefer it as the secondary rail for GX votes */
 	sec_id = IS_ERR_OR_NULL(gmxc) ? "mx.lvl" : "gmxc.lvl";
 
 	/* Build the GX votes */
-- 
2.47.3


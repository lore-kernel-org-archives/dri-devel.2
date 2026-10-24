Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3C606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X5PXkxML;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j3q6IEMM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9C6112D62;
	Sat, 24 Oct 2026 00:36:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03AF6112D6B
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:36:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvF0q297259
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jslaJ+w2HEyT9CXg0MOlXKm6PZnVP5VWPAUOBFNljSQ=; b=X5PXkxMLShfVuQpn
 RNM1czD4Xr9K5BPvqE5YMV5/fkXBKuCvX5kaFmCAc3N2KE/EOAGeT0pjYdZXlZX/
 4YbST8blcDp5A2NDlKMgOJkd4VcJZ6fwWHJwHWUXU8zRTVJqrdIM8RjHeWrhU5uP
 SfOj/cTcskr9F+dxhn7Pf7EAKjRjMmkRo1x2CU2ILKMvwptPdA2kn8Xy7hQ0dnxN
 lZbDddUSi7av9O8I6waKW5oZZA861JtZbsDQrJqS6lv+G87HkfOEZ1meQvOSAb7j
 AmbSPuhLRvG5atn5Qaj0U8mv+QzkdHMce5ud9yuUevdmMhtU8wQEMHgIQxa66Wbn
 Z0+ibA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgaruhha5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:36:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844e383so258138685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792802163; x=1793406963;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jslaJ+w2HEyT9CXg0MOlXKm6PZnVP5VWPAUOBFNljSQ=;
 b=j3q6IEMMnVBJxVSxpyoHvI3obrFkDE0ZDKH/NTDkeduxPTqTI4HIWhFWRsG365qm0W
 mgjn7R4sI6+/dRmmg1TC3KSZZBkYVxyoALJR0U9V+YVdCVZWgIMWDdSniyrr4xtLJPzr
 liiOUxDDqr0IaiQZQDzrJ78kZ3t4WdpBnogma1iWioknKNzxEknZ+5FDCW9B9+BKXab6
 Vu15nVTUdUeJ55cqBBNgsqu3YaL4s1WufTy1LZNG5MtlgiwxfLkUuvyOcQMEhxm5plxF
 f01+R9pwRLtvXC75ia/G7P3v9WoSoqTmat8PvE7sF6R4HzgC0ViwsZOIOU/j9hDF+02t
 SXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792802163; x=1793406963;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jslaJ+w2HEyT9CXg0MOlXKm6PZnVP5VWPAUOBFNljSQ=;
 b=HOPPKTtUAhQmlSdr4eOewUFj0MWaEK/a7uZuSNk36pJtDZ9VPnaqckuLEBOFEOuQlt
 XPSePeIopXbVMROOXORdx2Xu2RR4PqNdaburdty/PiVnMNo9aSb/zFrbD6MwvxrBVHHQ
 2qbztgN55ayIS7x5ZN0r+ZxCsIN+cV8Vbh/jL/9huBGo/pfRjKe2CYuuMMQEKHYVOVrG
 /8KCxioOqZ8E8T3bwDRxKW9CtHv8PayKel01LTy5a+FUW1l3iV+utrB7+d26WbC7dA5S
 02cCp1l80+vy0inFULgu6Ga9jzfFGAydX07qyCKVIWUQkOQ0p1p1eah1maAV5D7QHBUj
 i+eQ==
X-Gm-Message-State: AFq9FYJktUlLlUQ+xaGmPdrfvx6yn22La315yV6AZyQAdw6pG/CYV2Gp
 vqOLjm5BzTg/vTdI8A40XIXA7RCrCVTbO64hzJPd8IFBQn/Vyy2UL64tfjYk/cCfAjYI0IRfOfE
 rmKN6ABaNcL+m/Jo6bcEQfsPZhPC/f69fgMGAQjtDmE5h05gO/KIlkAO8WrGWJrDvNXGeA6M=
X-Gm-Gg: AYBFou27N10B+rQvhjb7sazkBqH52eTm40UDbbGc6mcm314wc35EAnWioZrR+0EjGMo
 Keexg1g4aMqTchnUTEmbE9r5Byxxe0PBHmwg8CCsD4z4HJKa2pS83NtRzfT/rxUCNE7fvg0bQHh
 at1sgS+aUP3g6v8eZoQUBPRtUKhAtZp8AvQEdHZHYTM3qlZgmaRvN426GOsTjHT9yhzaE0PkG4E
 QWJqY4/uDCqs0LmKKEqi5VaXzjG+9WiWLwJJJMlz/CSkYS3z2Ij8aZkYGzXgnRTNX+PU6OgPf7E
 gN/VhT1hwUxzh0if/QMXu59jOl+gntt2GNF/k1hh6ivynzZxBvvIDlwCdvdikTeWk3oPQcZGgCl
 JBW6ERJqU6CCsuOCgR4GhbrXMxlDCd9UEBf0jOblJGrnW5bGOE5Id2APWS+E90kfz5CYWpHMw1Q
 ya5fknCcXxSEc7
X-Received: by 2002:a05:620a:31a1:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-940ef956c10mr109937185a.46.1792802163112; 
 Fri, 23 Oct 2026 17:36:03 -0700 (PDT)
X-Received: by 2002:a05:620a:31a1:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-940ef956c10mr109934285a.46.1792802162668; 
 Fri, 23 Oct 2026 17:36:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709d1cf7sm1126651fa.15.2026.10.23.17.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:36:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 03:35:22 +0300
Subject: [PATCH v8 6/9] drm/msm/dp: don't take extra references on multiple
 plug events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-hpd-irq-events-v8-6-6ee949e7a384@oss.qualcomm.com>
References: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
In-Reply-To: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=y6Q7UwG8h2RY53M7Uj/FBYAupAUz6hR7YBAr9z2d9v0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2/1SgHKkiJWw2Q/RmkX21UPsNJT6d9sWxsWfN
 lGk1cDfUG2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatv9UgAKCRCLPIo+Aiko
 1abQCACx1C1gEiCjh/JA22nJY5oMv2sH85fmApV29ur3ZJHiuL544WoNV+08rQuI+2s1l7u0BfB
 pSH3B3HC6A7rQlqhDPIA2ruMLYYYjriz6QSC6lw/1JonyaVTNNm8xvMZ/VOSDO60jZpXprD143V
 EqlmhijNpaAWTY4Echcgkl1UjRZvVlWDS+tyd+BfNjvz5PIPoLfUR50gMU3moSgcfAV4eIbHFr3
 LQcvtn/0yLkoo4o5hAATZZOchduLmibkjvq2qCB7lkAlkqZMg6CummmnUdc3zBbEqljwccC3sPw
 wbS9DfpRqegDI381OagL0f5T4ASlv7jgolH3vPOzjKcXhbWk
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfX97TjEAObsTkA
 V7c6kUJylF3gyWIcHcY9iDnNB70OEZne8kLZKBIS7w4wzc7Pu5vk3MPxxSyS6v2hJ/gpfugeQbz
 jrS1Vos/D/rNM5WjWgJ6sDfGia6AwPw=
X-Proofpoint-GUID: iuKyvr4Oi-bjFNy37PBaO_uJMTTtxUBW
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbfd73 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=2dNI1gAXBh0p5IwnqgcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: iuKyvr4Oi-bjFNy37PBaO_uJMTTtxUBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfX9MBi3dysyBw6
 C43A8DX8GV5WHMTJUpT+zvv0IauvmHP7StJvQugOQfHDRbUvtG7jKo3rOvyN+LhEbOQt7l+j7Sh
 5lMFGwsXHA1mDJWql2u/z9JJ9x7yizgNQhlxZsgdnfkGpSscDin5D4INscSj5OT6ZsKD6eDMr8f
 O+A6fci1Ca93HT2p9Ujbx8JbfCjrxPfKLvKrA0ye3Kk//1tljxJ08ywtbp8sn0lG7TmQ20KvGl6
 46TlezHNng9dICzRSv3hjhRKmI/mYVheYofYW9W8z5BgczurKotV6ikrfxZZ6FRHIun5LvxwXyG
 nXEDiYek9/mhY4yv+8rB/X86tBPeYJ5xAu3c5hpu7MDxNJiwjP4UTNy9EFWlfRq7AJRHFaeuBlv
 VWxJh4x/JXiChpp+DGkNM9x+9jc6N2NmDIX9Gh3cc107YJ7i+nKypOi3hsPGc2vZ4OcpHNOBaq+
 JCGcd/h4xUolyKPFl+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240001
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

The upper layers might signal multiple sequential HPD plug events. Don't
take extra references and skip all further HPD plug events until we
receive the unplug event.

Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index fa8942922b53..ce919a26fba2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -412,6 +412,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	guard(mutex)(&dp->plugged_lock);
 
+	if (dp->plugged)
+		return 0;
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");

-- 
2.47.3


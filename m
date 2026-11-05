Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCF608360D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fY6CD2cp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NJkatHNS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5815110E10E;
	Thu,  5 Nov 2026 16:42:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3A610E10E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:42:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQ8ke094485
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 16:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=EOiK2c3+ca2/ATYQiSDG5q7j808nXXZYs1u
 t1t1o3Es=; b=fY6CD2cpRUe3o5DFfiF8JjFZ293O6h0KEfLnEC6mWvBxUvbKsCh
 g34slsQRdJi73Eg1GEeeVRlrLd3jNH6b0f6/2qRewN8gidc/PA1odwjCNp33Q9cG
 x9MECehBjoRGcjZhRhCO8pN6KpSns5TPCakUM5jFR/3hJACXxzJfi3FeC+i6UaFP
 v+idi/WjjBdO/zzwWf8vjKA1hpb66i3DMBQ/q7HxWBXaqMTE3PNrdRY2L8nPlOQL
 +ug/9rYwMR1sXYESgdyiSbWJz7Yto+A3WLrVE9EtQ41apI9ylns0vGGEp02QSDqb
 bVI/PR74/VTYVpscF5e1R2eAdFSJ/zCpMoA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43k5gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 16:42:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdaf2073b0cso1150490a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793896923; x=1794501723;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EOiK2c3+ca2/ATYQiSDG5q7j808nXXZYs1ut1t1o3Es=;
 b=NJkatHNSemBWzOcMR4Z/er6gxmMstgfHgcEOshK6GLZNfyqRPr9uno+1/ZCP0WGhHA
 VsSM7XOIh9u18HTMPZeaSuqvzO5q1g0jeCPSdrY9XCrpR30AP60xTQUZuVkmSuTuHHyH
 GZYkxRdMwFAEO7duy8pz+D1JJCKvPxV8jRdJ2DeI1qWhZ2xA6LEQn6IFQM7mCPhJqluz
 sScOOfCYw3FpLd/eExwvpxv7twXVMw8jqtugatpoSnR1CW8Fkbp/05WgDYn2Sd2v1oXt
 xorMGwQlrGDavJpLYAtPwgQy6Tm0en7n5+SK+Nvd4TCbnv8ODZbwxNU8+honA/QYGG3S
 t9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793896923; x=1794501723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EOiK2c3+ca2/ATYQiSDG5q7j808nXXZYs1ut1t1o3Es=;
 b=WcrxGTVyckG00bZiIhxTi053xHCyV49vQZdgU7PcSkhulTrZ8YJcNXRgxDArrcCg1s
 YWDOY6RH+niF1geu6n6PD5EpS6D6mKSl22THfikcaaMznQWsuevqD0N24Cq8/FOTmXkZ
 jigZP8ZpI5dsptjB2MMV15vPlH8EjnBHFA0N7dBMsLaJWpORcaQTSL/1VwSYA6dzc185
 wuag228eD+8/9Cttt2a2DicLKL56KgJYKdzQhzV4Fea2r8JF61bd0ky4bIcLoiQz0nhs
 BsPtkCul0cjhmOT/KE2sfw5SedbcClATaWJ5PAXl6RhgI1uPjCbPoIUJlJ+5jpsiZUWo
 C7jg==
X-Gm-Message-State: APuU4Z9ek1d+xeXQcfo8iaNi/no7/FKuky0HcEsiVKKAdFLGcCHOQs08
 wMtOvczz+GDN6XvtVDGtkW4JAvGR4EE0SQSzUMNiuHpkl9zbTTD/DfTTsrbah64qhqm11/RSxlF
 iky5N7wZ7fVTHG+nPUJZPxkxstUcr8wKFv2YFMbrDYV/ip5Kl+k+figv18j9Ou9mmUa2NfFtf2S
 OfqWdcTQ==
X-Gm-Gg: AYBFou06mHDB61gGf0Ax+jsqN8Pt+tf/+HYeHXg4VwFG9DlLVTlAkMsr60cFXYMGaWD
 VsSZ8TLyD/m3qR7vdMvRKpt+y42u2ShcyRina+Ws5P7Kcy2sgmWTL3e26swvxXikEaPMacuGxSm
 Stiu1519g9+qSv7eG9tyCDChl87aBiTXUcBOV9/aOKojvSp6gdXyx/gokxsu0PqFn7pVCBMjS75
 QQFEgYdpjNEQp0jXH9wh8MyuYi58Cyrg17TUubZnrJ/dEy3Q7FocyjZ56x5w8O6aDZZF0QVGxo2
 H/cgx+ZTRMD176cuOz7Ju46vM3lk/dZtTyUE+YTBvdokJfycK1pke3jVyPnFQLgcknvDyscDr2N
 LjZFRMlaQnZK89Kji0qmE5/6237QGXfMLzcm6vP37yigSxhPxKpsCzP9TppZ7b05/Hqahm0EpK6
 7SYKeXdyk04x3Wvt0ALibpZhizhRb6bnjWFj6UrSrW7mJJusRj89xzRz9Za1nC
X-Received: by 2002:a17:903:18b:b0:2e8:93b5:c555 with SMTP id
 d9443c01a7336-2ed40e29864mr1399345ad.61.1793896923232; 
 Thu, 05 Nov 2026 08:42:03 -0800 (PST)
X-Received: by 2002:a17:903:18b:b0:2e8:93b5:c555 with SMTP id
 d9443c01a7336-2ed40e29864mr1399005ad.61.1793896922543; 
 Thu, 05 Nov 2026 08:42:02 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed0f24d9dcsm19326435ad.65.2026.11.05.08.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:42:02 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v6 0/6] drm/msm: Decouple IFPC disable and sysprof
Date: Thu,  5 Nov 2026 08:41:47 -0800
Message-ID: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jBAGdDYOFhwkixfXQSr3-Oh1wlCdbI1E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfXwvofDVGObj8o
 DBFoSd2t7c6zwKrfPkGUV1sMgw5nX1Fk9I/cz1aGmfvzBq77X6El7BnuX7g8+pwenvdVBQqH1Co
 eoqRcMilt0Vu7tlK45Dizx9ESvVKoYHJQDafzm9qoz+76s43ubHzZc8udInXz8RI9utXJxDB41U
 JxCllchDyarJCpkaHBHE5XX7+TUNwcefpHc/16TO+CLFB1vBLSMAtg1und/f4/hmqrb+fAXKwFi
 GJ8dtbcAi/R2PlVVLyykJqEMHXYGLWBa62wU2rQzgm+12xKcZVPlv0eJOWkWRRaKNrrnDSkfeHH
 1zJv8YI0ZjMzPkrcZzhk7NKlzkq5bQZ5c1AT1AHbC+oKFzaWpyOHa3nVw1bTQj3iuqnQyxsjIeO
 gi/1VT7mJprfTF9TWvXhqjGGtQ1GKgXI2TA26QWbs48LEQ59E67/FdO8BW+GqShpsPW995bkedY
 zjPZRiHmroyuZdaTXkA==
X-Proofpoint-GUID: jBAGdDYOFhwkixfXQSr3-Oh1wlCdbI1E
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aecb1dc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pAKKPEBcNh-_eZAUbWwA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfXyEJjIY1+S9uy
 OssYzrtNTbpsRyOAQH9mmo04Veu8Hd2OUzXk1Rdf83eEMK3EwJsRcyvhNz1bdV+HyVmZXhWB5SH
 kt1BDHPZqHjPgmAdCupbwACCkcF/8v8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050066
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert IFPC-disable into it's own refcnt so that multiple threads can
request IFPC to be disabled without stomping on each other.

Extracted out of gen8 GPU state capture series[1], as other than fixing
a missing IFPC disable in debugfs state capture path, it is unrelated.

[1] https://patchwork.freedesktop.org/series/176505/

v6:
- Fix potential runpm ref leak in sel_worker()
- Acquire gpu->lock before runpm
- Fix unmatched OOB clear in a6xx_gmu_shutdown()
- Link to v5: https://lore.kernel.org/all/20261104175931.28475-1-robin.clark@oss.qualcomm.com/

v5:
- Skip unneeded msm_context_set_sysprof() call in msm_postclose()
- Fix potential sel_worker deadlock
- Revert back to original gpu-lock/runpm ordering
- Link to v4: https://lore.kernel.org/all/20261103231850.17493-1-robin.clark@oss.qualcomm.com/

v4:
- Don't clear GMU_STATUS_OOB_PERF_SET in suspend path.  Restore it in
  hw_init()
- Don't require gpu->lock in a6xx_gmu_ifpc_update(), but instead warn
  if needs_hw_init
- Move perfcntr resume to after hw_init()
- Link to v3: https://lore.kernel.org/all/20261103184713.29664-1-robin.clark@oss.qualcomm.com

v3:
- Rework IFPC disable harder to play nicer with hw_init().  If we
  need_hw_init, simply update gmu->status mask and let hw_init()
  restore the OOB request in a sequence that won't anger the fw.
- Link to v2: https://lore.kernel.org/all/20261102190010.720443-1-robin.clark@oss.qualcomm.com/

v2:
- Fix double acquire of gmu->lock
- Fix missing a8xx hw_init() path
- Link to v1: https://lore.kernel.org/all/20261101174631.23637-1-robin.clark@oss.qualcomm.com/


Rob Clark (6):
  drm/msm: Hold runpm ref in set_sysprof()
  drm/msm: Resume perfcntrs after hw_init
  drm/msm: Rework IFPC disable
  drm/msm: Add cleanup help for disabling IFPC
  drm/msm/debugfs: Use cleanup.h for gpu state dump
  drm/msm: Inhibit IFPC for state snapshot

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 27 +++++++----------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  9 +++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c      |  3 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c |  5 +---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  1 -
 drivers/gpu/drm/msm/msm_debugfs.c          | 32 +++++++++-----------
 drivers/gpu/drm/msm/msm_drv.c              |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c              |  5 +++-
 drivers/gpu/drm/msm/msm_gpu.h              | 34 ++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_perfcntr.c         | 17 ++++++-----
 drivers/gpu/drm/msm/msm_submitqueue.c      | 20 +++++++++----
 12 files changed, 94 insertions(+), 63 deletions(-)

-- 
2.56.0


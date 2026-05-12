Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADD6CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 20:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B696810E59B;
	Tue, 12 May 2026 20:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="chpvL1Wv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPuF5DxK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA1B10E590
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CEJLrT424410
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0TfT9/ZENEWRRgEaK0B1NiaestVhC04N/iYksXpa6E4=; b=chpvL1WvjXIB/32u
 6sM/GzBgEY+Mlmm+XfJ5HWF1eCNW//npW75RwsDUisXcJ3kzCYvCanc/peFhFL7E
 IVD1FUAqLc9mRX4ke4ofuTZmvOCzU5Wugnf07xbA21VMOFr4puJRv3gfa2X3a4aq
 0lZDVH+4hVU85LhbeRd9vFpBiSCyGIVRwIzT3ymzVUN373y6FM4tZ/zxzLiODkP5
 CmyIC9vrYqEVZjoYfRjLeBJJYeaOoLR+y1IP1YzdG5Za3cdTeSNLJFEUIIWhqioR
 IWI2CHbQYHC7mKCU0nfgy2Aj+q2qQkCF4ty4RuRRfpU7Re6CXcGVSLUD7+XPF94E
 A+8qdw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45v59fre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:53:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-83565161a6eso3570003b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778619203; x=1779224003;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0TfT9/ZENEWRRgEaK0B1NiaestVhC04N/iYksXpa6E4=;
 b=gPuF5DxK4Jgfa4vLrw8LtayRKd4N+hvzut/03vH9ER5HRdG2kziJF8i7qRtqMTGgij
 svOpU3fuKeNcAWI/yXY06Vt0+XzR2ueOnk1jnzztoaBbz1T4j80ZqCF5LQDuLXsigbcr
 FKJK4yIxt3DImRmd9y+HJ6t1xlKYGbmaJGkMvivEKXh3V+U+yLU/eMUGm8YBwfxSGKKh
 hfbNP5kmmSeGrs1U+2+5MzwzxawxJYP+LfnQ8lBD95nsLp1AXWVlDstXjpV8KqDnWFY+
 lKD0T64+cg+fZkLXT7W0sdcSARazEl0UylaZG2fsO5ugD/Y8btPkvNfvoNVa++jSG79t
 SY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619203; x=1779224003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0TfT9/ZENEWRRgEaK0B1NiaestVhC04N/iYksXpa6E4=;
 b=OhLcApC2ZZwUm1viiyOiXxwVmYCTNzh1faHK3juCNcP4ONLNx2z/TpB9natO9Q2R0c
 11PkTwT5dedb8S2x/+gqoyfLJx4r41Z3nikt2JlJy+/q6gb8SRXHyjYEqBaMyBFMfr38
 Ttw9cxN8243VT7dpX0wOGt9N7iUVTPzuFEZouE7Jkw7JnmRaPp6RxtSRi02LCnaN0bR+
 NvLWglKqbzFXiVBtOuqGut/f1BlB+WMxaCNnqbgdgLSW8KUHRYiyzhwatNMWcoAXenzc
 XhAhd6RAEyWEjxxf5aoZsMpqGQFYQKIdbFslp0LSLLu6r3LYFgtezl756WltbM1OvtC7
 o3DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nOW9maR6X3FoPbVTOI75MvDZBhm56kH6eHynsRL9MbM4jzqbn4inqyk2y2OMpcjFmCgvfvi7QofU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTRr36f81o2zxw/aC0TlYPiuNOOSglfkVKIZ3Py6VJSL1eSn5Y
 dhNrqm0rebLpfCgwW0Ku+ZX3SgKDQswZNdc+aVwb3GZqBEUnv+LkkzqDCWoN/0rnopsDW8swrGM
 Ww0AaFZTDq6FBy5JH7OHO67arFDfQIe2fxzpduX1oPxHn72uGV7yGzF9fQSzjQYLlPMQzf2Y=
X-Gm-Gg: Acq92OGcopKRPSyaOz69ghaFUVYvb9pEkqLOIBuh/6O8JXAtMDtPE1Ahvm/vQvt43rI
 yN+JAMCU2/syiKkWHrUQebg94sD9UwZhZX6t37xS4Q0+TAmDSDd2fM4O75k8nSr5w1+jPOqNN3Q
 IGZ4w+URKhR2MYLWWZd4lz6vDFWFu3f60vTDx6RuJE1B2dw4VUj+ZNX2fkeH/UU8IsbjvUAyM3z
 CCbfH0FdrL2q1LQXUL+8DbPRrkbOqGfpyyvQLi29sCN+In3S+BltMZp+bsGKtv8Z2M6FUhWtAd3
 nQ4gPjudFId5U174JumWbmE7tN0ctk0f3NMG+StmUIb6Ne3uCICgXq3ooE/pxvVxXFl4k8Bzguc
 mcErVIS9pPQE4C4vghPg4IPnespCCA1Y/qhfkwkCTj5LsmQ==
X-Received: by 2002:a05:6a00:4516:b0:837:8342:abe5 with SMTP id
 d2e1a72fcca58-83ee83ac2c1mr4769637b3a.18.1778619203214; 
 Tue, 12 May 2026 13:53:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:4516:b0:837:8342:abe5 with SMTP id
 d2e1a72fcca58-83ee83ac2c1mr4769612b3a.18.1778619202731; 
 Tue, 12 May 2026 13:53:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945c1bsm25453004b3a.15.2026.05.12.13.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:53:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 02:22:56 +0530
Subject: [PATCH RFT 1/5] drm/msm/adreno/a6xx: Mark cxpd device_link as
 stateless
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-gmu-sync-state-fix-v1-1-6e33e6aa9b4f@oss.qualcomm.com>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
In-Reply-To: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778619193; l=4014;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=8x5dChKVCVCMOobD3xTgj2pX4wLUI672qR53c65MycA=;
 b=GgzRnj+PeTNAinxeGf3LKVTfwIeGmZL2ZE4i65X8LKrK/TFSMNBIxaVUeuo+GOUJMtbPnkv8w
 XzoulC4YQ2mDmMmQjJiuu6gHMjBHzGdeROiTiLnRmSYC/szVweFdcoO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxNCBTYWx0ZWRfX0ugcBNRWZcSE
 n4RSn4+MIrxsvwAXmWjjHwErmp3ziUoUtFj0VqwTveiLfTzyEYZltuBaLc2M3y03sAe+oA05Y3G
 HAdZAra+/y0V3SfY+fHHYYJFHnCESmrOYqWUhYctvfBwHU2Lfh6JuATY7hmfJ/vKjItVodxpkRJ
 m2iqvitZXVpiSY0/scD7j6tMMsMPnFDzDVF91NYaa4ESd0+5xKNibqVcNvo12kP64ZgwkM4Ns/d
 jBDAAdFdFFKPCrY+ipNryLt/GoTASIS5pWOXN6sZfyf83UnjBnVhfxsVWbf6ljFw1glG1Gvt8Y/
 nqUl+gGKGd/u63u0mLrrvXN2e/NwhZjEGKMrBGY7J/F7VQ9MxCDJkF++1gaLk4sRQbUwgZN2koU
 iHCtvlVDkyX/CW43Wb3uaxG0igdRzoFqRA+q59cWSgr84c2ZNc3yuiY6V0d6JNtm2VFEpVshORJ
 GSCHakwxnzjXYx3aYUQ==
X-Authority-Analysis: v=2.4 cv=GZ8nWwXL c=1 sm=1 tr=0 ts=6a039343 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=I6AzIoMvu9cqgKTuVesA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: s1rVUTFq1EiFqdC-KSzk_bDNok5LKSM0
X-Proofpoint-ORIG-GUID: s1rVUTFq1EiFqdC-KSzk_bDNok5LKSM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120214
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Since the cxpd virtual device is a driverless device, it has no real
struct device_driver bound it the way a normal platform device does. So,
the managed lifecycle doesn't map cleanly onto it. Since the lifecycle of
this device_link is managed by the msm driver, pass DL_FLAG_STATELESS
together with the existing DL_FLAG_PM_RUNTIME flag.

This fix is required to avoid the below splat when a driver is attached to
the GMU:

[    9.624509] WARNING: drivers/base/core.c:1383 at dvice_links_driver_bound+0x178/0x330, CPU#6: (udev-worker)/354e
[    9.781167] pc : device_links_driver_bound+0x178/0x330
[    9.786456] lr : device_links_driver_bound+0x158/0x330
[    9.798622] sp : ffff8000827bb820
[    9.802042] x29: ffff8000827bb820 x28: ffff000808915800 x27: 0000000000000044
[    9.809573] x26: ffffb7caf3f983d0 x25: 0000000000000003 x24: ffffb7caf41645a0
[    9.816920] x23: ffffb7caf3f982d8 x22: ffff000801239cb8 x21: ffff000801239c10
[    9.816921] x20: ffff00080b3a8c00 x19: ffff000801239c98 x18: 00000000ffffffff
[    9.816922] x17: 736d5b2073706f5f x16: ffffb7caf1eb5940 x15: ffff8001027bb3b7
[    9.816922] x14: 0000000000000026 x13: ffff00080084c110 x12: 0000000000000000
[    9.816923] x11: ffff0008004a5828 x10: ffff0008004a56d0 x9 : ffffb7caf2227870
[    9.816924] x8 : ffff0008004a56f8 x7 : 0000000000000001 x6 : 0000000000001000ocket.
[    9.816925] x5 : 00000000001a7fbf x4 : ffff0008004a56e8 x3 : ffff000801238cc8
[    9.816926] x2 : ffffb7caf4164000 x1 : ffff000801239c10 x0 : 0000000000000000
[    9.816927] Call trace:
[    9.816927]  device_links_driver_bound+0x178/0x330 (P)
[    9.893492]  driver_bound+0x7c/0xd0
[    9.893493]  really_probe+0x208/0x2a8
[    9.893495]  __driver_probe_device+0x88/0x170
[    9.893496]  driver_probe_device+0x44/0x178
[    9.909639]  __driver_attach+0x9c/0x1b8
[    9.913592]  bus_for_each_dev+0x7c/0xe8System Message Bus Socket.
[    9.925839]  driver_attach+0x2c/0x40
[    9.929733]  bus_add_driver+0xec/0x218
[    9.933609]  driver_register+0x68/0x138
[    9.937555]  __platform_driver_register+0x2c/0x40
[    9.937556]  adreno_gmu_register+0x2c/0x40 [msm]
[    9.947141]  adreno_register+0x3c/0x50 [msm]
[    9.951544]  msm_drm_register+0x50/0x78 [msm]for the API...
[    9.962813]  do_one_initcall+0x4c/0x3e0
[    9.966975]  do_init_module+0x60/0x280
[    9.970849]  load_module+0x1c70/0x1fa0
[    9.974708]  init_module_from_file+0xdc/0x100
[    9.979188]  __arm64_sys_finit_module+0x1c0/0x2e0
[    9.984026]  invoke_syscall+0x5c/0x120
[    9.987882]  el0_svc_common.constprop.0+0xd0/0xf8
[    9.992715]  do_el0_svc+0x28/0x40
[    9.995243] qcom_q6v5_pas 6800000.remoteproc: Handover signaled, but it already happened
[    9.996128]  el0_svc+0x38/0x148
[   10.007672]  el0t_64_sync_handler+0xa0/0xe8
[   10.011975]  el0t_64_sync+0x198/0x1a0

Fixes: ead5d3e5eb37 ("drm/msm/a6xx: Vote for cx gdsc from gpu driver")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad8..ec13b27feee7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2196,7 +2196,8 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_mmio;
 	}
 
-	if (!device_link_add(gmu->dev, gmu->cxpd, DL_FLAG_PM_RUNTIME)) {
+	if (!device_link_add(gmu->dev, gmu->cxpd,
+			     DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS)) {
 		ret = -ENODEV;
 		goto detach_cxpd;
 	}
@@ -2377,7 +2378,8 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_mmio;
 	}
 
-	link = device_link_add(gmu->dev, gmu->cxpd, DL_FLAG_PM_RUNTIME);
+	link = device_link_add(gmu->dev, gmu->cxpd,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
 	if (!link) {
 		ret = -ENODEV;
 		goto detach_cxpd;

-- 
2.51.0


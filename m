Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE1606A327
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uz5WjJ9a;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hhxlxo1r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A169010E140;
	Fri, 30 Oct 2026 17:10:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D034D10E140
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:51 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERMKR2968204
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 viPmlgQ0jNGVSBO2/t9bsFtu5pNzCSof1faqWlhy4tU=; b=Uz5WjJ9aDbXKwoY4
 vgYe15ESRy3fkoRkwEZhLJQJgW4b5lIyQnXJJPCWYUCRmthFVIMGqTnUY6s3mCE7
 yxGeKrCgKc838xh048smVH/YWUdUw6tcf44HVztBH3Z0bhm00tCZ6ReSgQp5seuy
 vEfW9gJmemAjgvA2sqtoehz3bCn2Z79Mg9PCFAKTFDskQT0YAZXzzyP09a260XA+
 oEYaHv1imnKOynMt7f/+FA9pBJNDjrTDOOlVZFwy2MsauqI3gHYDDR0LenV+myxb
 rMXSuokz+gT0aLpma1palrTixQpampGsFJRxJOFP6kOFbb4vTIPoNQm34+lrUYaE
 RZcurw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm5nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:50 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1ac19c6bc71so901944c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380190; x=1793984990;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=viPmlgQ0jNGVSBO2/t9bsFtu5pNzCSof1faqWlhy4tU=;
 b=Hhxlxo1roBGWpbPzGHeIRRxAilfx0Ct1fHMoC8tNzgNGVsJ7Xchgyl8T+rYVUsieqM
 4r8eO0wwe/S659xrNF/EhgGBwyBflmhuImcPST4CUMDMwB6kQOeX3d94Ve6ATG38AS9q
 fQTJyrZV15XuXXd2/bKuKlEqV+faUmuKnlxEXcAkWy/zv0m074eB0UeeCvKsXXKt8UIb
 jEzuDSwLmgnzEHXUGR2Iiaa8mvmKBGMaE15chlm2Y6vbvFrAEHco4ZybUch+9Dn7GNQ5
 9Z7Zu8tIcsXIYTXTfqV74lT6uFH2oxh5Plr7ENrPl4SkMgzax3PncwkcNpVOLYZwuSqe
 wBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380190; x=1793984990;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=viPmlgQ0jNGVSBO2/t9bsFtu5pNzCSof1faqWlhy4tU=;
 b=YV4tnTACnIIUsuSST9UQ3g4DxUsWZlPaIYfP7RGFQtKsWoNx8ChIqEoivfxbIj8XIf
 s+vGkeRwOzUZuVqqMpfS3vg0v7IVItFqui7HxGDoIP81VLQTOONMn4TxvvUgmBcN7HaX
 /QuGsQM91+ahpMoXPB4Cz5OTU1tvdPWPMjUnrR6zcHn7bfBfDL6CRvKNPiZqIosPzWNH
 msMzJ/+i9BLbjZneGj6mMGmwEaqdxRwOw6LJztBY+47T2nugEpOc+QvLd3qahjkrJRek
 G6qDbdWlP2lN5Me2kN4A4rNCTkJl6q2pQ+zk09Cexi3ekq52GDrp5hd1tC1bmN7dSJed
 1tQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDQKh/A2uqJu5PaqPIG3dizYHCYNIyHAXUAgrLlRyOHPhUJdW9XLdJWLd+p54EkmYJyyJGmlimIRk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI6k7Ih66H/L8PICLd78z+TZgvLZ6Zwy7VpxqvJhGU7MDvwsb6F
 p7xWlJ2y5xzi1+uoHIeGcccFRTba5BdytPct7EOq80Bao2NkiVZpkIPtzye9K8/gWj++XXHwGt9
 lod9t5qewgRa6Tp4R01U1uzyOvkrBd2XXZDsccvavoB/m+hiFEFpPpBxkdC9lImlZIXhTZqY=
X-Gm-Gg: AYBFou2TBCRLSBgw+5uq92O5SmRnoKeScWdJ0LezctcYBwSRNm6xshSBzEaWUuXEAzq
 wWyiF2s9O4lwRXCdVSblBfgoXbpwFS3OLHWpMrlwE/+rmh9POyJEoNU2eKjUxfkuHbmnObxesME
 pSsPCQ/3xax3yyOk4t3fIImGc+7ns6xRqo14IRKtC6tEcoSnPmcoO5Wtma3zAIgD9xhec7BTi9b
 lW049qyjm5IsNnzroEIsQK6lIjqGwhYfXi2OFnElxdN/3dvzu3yygAkV+8tpogf4fTRIi7x8S5h
 WR62qrXQ7a4Ur6+mn5lW5ExpnXhU0OvoYYvKVFiUGgqrRNcJi1umGcMIqDTgq/GFhewJS+C6NnD
 28M/83fMUwwPsPoRp8SZHRXrJsZD3AjbLcMRZU7siUw9enzFtK5XK+5erhuaC9WFPeT5fJ7Q8EA
 ==
X-Received: by 2002:a05:701b:2816:b0:144:e246:a0b2 with SMTP id
 a92af1059eb24-1ac6088a458mr3842290c88.44.1793380189779; 
 Fri, 30 Oct 2026 10:09:49 -0700 (PDT)
X-Received: by 2002:a05:701b:2816:b0:144:e246:a0b2 with SMTP id
 a92af1059eb24-1ac6088a458mr3842242c88.44.1793380188962; 
 Fri, 30 Oct 2026 10:09:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:09:48 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:39:23 +0530
Subject: [PATCH v2 2/8] drm/msm/adreno/a6xx: Mark cxpd device_link as stateless
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-gmu-sync-state-fix-v2-2-89d3082d97af@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380168; l=4089;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=gWi/hNKGHqX3nrtnTUpvlxMi6EWilTYIlUPxFnPEmi8=;
 b=s+xJNk2gDey/o7vQkpf5w6xvEZk3xV5QhVdWnKRQ7pX7+VQp5iSIy6Ty2289FF/hZmQrskKZo
 XECef/jDMOsBqb8VhYq8IsEBGK8WDwdVPxpFjPzTTmxxbk1WdKROdXY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfXxQdPXctwgFox
 eXOERAKvFcjwMoljdCFpZUsZsHfVt12v60/6osTWEDNd+GUfj2qCqr8Qgr7mY+NNZIMZKTXuDQL
 pcvmne/5TR1Pc2qz/5whmn1mI7EuMfV5PdveE6yr5h/aW5DsNIcgRO2hLbebFZAcpoew7P+QhzY
 23ON0AICn6ZLAVG7OdOaKbroEVLH7qdYZoIo1pDem8djsSvySUZv7k4Q8BCAbLhDHF+W6TFFy77
 s6NYx3Xwxf6RtWJNbt7SQbWPHkdL4kSLcFHeOA//ZgRh2+92yhmBwGKGpzhjU1b78LBsXj7oFrb
 PBpW9FtJP5OLMTV9QpiJpN/PZrQJyOwQNbVazKm3plsAuYS8hHmFQo9+gIN9I9AdLO7lsVLOd/v
 VLQle38V9KDjFVfusNZHJvO9+6GDmUyNNoHSdXDLPePJpmJohaVQXJe+1Q5IQBiX9s05b2HeQUy
 R7IN3+0KAv3IFBwNNCw==
X-Proofpoint-GUID: Nmpl1ZPWKOWq9vKas6nQtCLV_bkjTAVx
X-Proofpoint-ORIG-GUID: Nmpl1ZPWKOWq9vKas6nQtCLV_bkjTAVx
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4cf5e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JUlh0KM8FqsLYbc_jwsA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfXwq673/RFtymQ
 wKzcPp41CQKwwui4IaS8gRy0cnVBYggvP96hqxG9HLLQ/zfC/yNVv17BXTF+LYMydEOtIUIHYGk
 roELfxaP3Wcx78j3GSt/JcWc8A3nwFg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300068
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

Since the cxpd virtual device is a driverless device, it has no real
struct device_driver bound to it the way a normal platform device does. So,
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..5d96b55a624a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2291,7 +2291,8 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_mmio;
 	}
 
-	if (!device_link_add(gmu->dev, gmu->cxpd, DL_FLAG_PM_RUNTIME)) {
+	if (!device_link_add(gmu->dev, gmu->cxpd,
+			     DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS)) {
 		ret = -ENODEV;
 		goto detach_cxpd;
 	}
@@ -2478,7 +2479,8 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_mmio;
 	}
 
-	cx_link = device_link_add(gmu->dev, gmu->cxpd, DL_FLAG_PM_RUNTIME);
+	cx_link = device_link_add(gmu->dev, gmu->cxpd,
+				  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
 	if (!cx_link) {
 		ret = -ENODEV;
 		goto detach_cxpd;

-- 
2.55.0


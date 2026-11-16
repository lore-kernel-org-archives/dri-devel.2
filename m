Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5B606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EPpDFUWO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cN55x2lt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEF210F192;
	Mon, 16 Nov 2026 13:18:42 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F86E10F182
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:31 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0uDj2472430
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t2gbUgDpflbrc/m4hWyeER2/DcJMobhjIE5yYWx4KBs=; b=EPpDFUWOkZ5L4D/K
 1BoTCAv07el9Qc7jt/26GUGF8ENgjQm4+R8ZyEaaSr/8vYF8ZDeaOicnrIYrZijA
 mZxTD3sfs/yujgTaHQQuIdEViZg+c3h7lCJqSFOeYe24TNs75A+Ag8Vzf6PeyReI
 1TS7u2A9ovivRK+q01qw6aTF9/zU48VVUF+K6H0sLqidRhRCoSe6aEpNY1Yo26ed
 oBmaBXmmSrwNB+vDlUpJb1Me9Ch7vzcaAbxhNtMOcBWfhm8q9xJB/sfVhGae62XK
 hp7v75ikoc5Udb5UQWxNXyVp05vfEibNk+euURuqhvI2f/nvrcZn9IX28SvW7lLI
 UOYqxg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdxhre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2373e9b4so371766085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835109; x=1795439909;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t2gbUgDpflbrc/m4hWyeER2/DcJMobhjIE5yYWx4KBs=;
 b=cN55x2lt1AkuXx2CR0+PfyEJaurJ55Fypv/FFhRS1suCuTlc5hR7TUTjT0T6SL0FIq
 NcfCXJzQRlR5m3mHLkI+TElJ1vZYQeLD/1TPodiYX8rB0WmhgC8u/yVxZEylQcf7k9ts
 bAHsUCwcweiKRzV37IEr0ZwpBHAFJV9pdRNb4VDPJIdyZTzqmZtg6Ybv/8K8idRrG/+3
 2iZJnkiVAq/jLWSjqlvy/Iw6J3DrUVPgGL0+g10PWU86SeTuNVmwdPZhPBFAOQZ2idXa
 BhWcFivUY+MMO9G7hV0JdBs3YvXwMb8hIFAy2wrR0hSbNM4cj8VcQMYKC/u5fVJjkUf4
 xiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835109; x=1795439909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t2gbUgDpflbrc/m4hWyeER2/DcJMobhjIE5yYWx4KBs=;
 b=YjLaTXNTKtckE1TX4ydncidJgse5sL2R1YHe6BKp8JvuGsz228BUwQlvJOHlcEGk/z
 svHI8PYi5126+8x2wIYPHzmII79aQ5v9VpuruTgx/K4q46jtV7rueENMTJ324qrWvc+M
 99hwhcxVClo9q9Z9jBVpBDafFh1iGD5Dhp0xLrtqKadR+g3/Jp3Dg1eriidgzZq20GbI
 20uo0Z8vRYZwTl1R5XFX3kcRZFAfPPlXI0AZXvVz0ug1Pnwh74z+Offr/eEJj5NvPch6
 WXwM68hDGPNeJ63lIqPaMUrlLCysR5zqBjHuXT4QSte1VX7xYRDzo6zAsFHpiYS4u8hK
 F/TA==
X-Forwarded-Encrypted: i=1;
 AL+hErGpJwT1ITnVrBjf/s8+/BpkuPrkRywqN4epy+1QWDErbEq6UhK1cxgaxYsvJWpEuppFYEQ9PwVYHN8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+1G5ZMAJlkSDYaqUxb3its+XX50uMWnyZK+pK0UkEsRDzYpNyS
 rYoRqYr1X95ibm34Z9qVe6iU/n0lk2opFmtzjvdQXOiUzI70IVyoBIl+hfuLv0Flzm03JYuLAQz
 yJydHdERSLYEWpJP177dbsDvEmeuwApZygziJpc+fSsqwv1n7P37lxaMOWlEO8H20CTXlOOM=
X-Gm-Gg: AYBFou32bc4On95G/Akl5PtQwzc1nijQVkRoPxRQNFqhk9rO+IqYdtb1dCxLfxauqEp
 0hRRDCi0KVlkmJBpAz86ptWWVhuokPXKzUfyr62b+RsuSIk9JglcnOaV2RCtTIoIY4LGKdSnPyu
 n2CnI4Mqd6WkB01yy2iQ/SkjiUfBdQWU4yWZi3ttvRrmNdjewPDMa0aI2r1KNuG5tcnx/BfdUDC
 It/D183aCfP8JggsNaQV6URmwz1KWnYmQvAfwFrUeMG9GyvkKdoHZz4YPVDo7IugH7XTQESMCM6
 xEoNHmiD0QV9xQ+JlIMbWCnOa/wpa+y2VReY7nEuDkmmNcvwfT2Fbog+s+zHi463Fiawkx4IWHJ
 TKQuhuyPmmAwK5Sv83IfJs6HYl9+UMtyeKxOOpKIXtzQrY8Xo+OAxGSH8N9kC/TlX3K3XNiLVLv
 JF
X-Received: by 2002:a05:620a:688b:b0:93a:2221:5460 with SMTP id
 af79cd13be357-9494bbe7d6bmr1466808285a.40.1794835109463; 
 Mon, 16 Nov 2026 05:18:29 -0800 (PST)
X-Received: by 2002:a05:620a:688b:b0:93a:2221:5460 with SMTP id
 af79cd13be357-9494bbe7d6bmr1466801585a.40.1794835108814; 
 Mon, 16 Nov 2026 05:18:28 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:18:28 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:47 +0530
Subject: [PATCH v3 08/11] drm/msm/dp: Add support for DP controllers on
 Nord
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-nord-drv-dt-v3-8-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=1225;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=XJxZ9JOwZTbboBKfrzjZDalKlNgV2kQ+8L218FILiig=;
 b=O6r8EyI2nMi9A+cCkAFWcnDMztGvOvMYd/RUd8W9f3dPKb4b957WRmfYDKWVO5OVbAESJTXGR
 faA/HpH0XxiBiH4DIZOdzsKAL8xx3dgfsxJjei+Z8ud1SGYMQYl8RGO
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afb02a6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tTS4mT6h1kkz99yYBxkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX0kBh6ZcssH/J
 HbtX3kMMCrHDNiuHf8Bfx055ZeLcH54WpoM/GCisFIuX/5p9JXsd8YQDebXbJ+basGUMhE1GhRo
 JzRmp1CIrjHFas0D+sY7Av0l9nFhqW8=
X-Proofpoint-ORIG-GUID: RitHNnJP46OMtC8GpBmh61Jh_lil_aH9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX/t4+LKKIUPrF
 Q2XChrTK+bdmccT7F/yqoHwYti71Id0EzqMm6OZWKxtombrXSlBV6NX+YD76LaQhCHgPLVxE/oh
 INHiTbMyLtSSFOx9I83vXaDQ/25DMGM4Z3+nKocEJja9a6SM67hw0hy2yi7YTjEivg8X40i6ZFI
 G8f6+1VhfTJ7oUyVOHOYMa0P8UpnKHgZvcf/cQxiO1J9TrZdahXWh98ypYD+IowsepOm64fDvYJ
 S8egoapHYEbt9mbWaMMbgncP2Idatl0AnBd25u/3W5SjWbG4pbYACWHF5enaKLX96adwE6TZwkc
 z4c+wtoRuQzZnIFOzEgnRCf1VEyHhQdwpvfxrvkq6deHsg7vYSWaIH+Odqnn3BvAOvT8NyL7QYX
 RnMMHsVb7+G3KC9mFQfn9Q2YAMozxpI6SUX+KnUHT65qIl3bbDv0iOTux5ZspJA+HHqqzcuf0/y
 hZVEH5pye6YE+XcQkhQ==
X-Proofpoint-GUID: RitHNnJP46OMtC8GpBmh61Jh_lil_aH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Nord has two MDSS instances, each with two DP controllers. The IO
start addresses for the first MDSS instance's DP controllers are
already covered by the existing SA8775P descriptor table. Add the
IO start addresses for the second MDSS instance's DP controller.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..8b1b01af11cf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -108,6 +108,8 @@ static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
 	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x08d54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x08d5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{}
 };
 

-- 
2.34.1


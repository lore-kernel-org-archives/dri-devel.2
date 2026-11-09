Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499E606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lnKMZmGt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eUCJuDga
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E921E10F0EC;
	Mon,  9 Nov 2026 08:37:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2611D10E86B
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:37:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96AYlo066308
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 08:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8XtxpwepNLFe4At2B+OUT9XResQf2iFVDrkaX3oWwYA=; b=lnKMZmGtCPDBiFDV
 O+2J3/bw25IP3lHVDXfZ+xEfGEQhOQfAE2kr9LyOa8YLzd+aKMP6uQKrpzHYdXDQ
 K+OhhRyt61g0L64vXr3sGCow2GbkPU0jGUekTLJSwhTwMMRCCdGepvV/LaLSPDDD
 VVujFEDpsPMVdVT0pb0YGUrTEknGGNFmTRE+HZyLoragy+4Cd5u6Y5ZoTnybjp6p
 Yxq0401Yo6/L1yap0VRCQzxQF2fbqOaK603Wv0Jt69VZHx/Fiy9G27uBvTgnLBu2
 /UrpqciPcTtr36VL3ZFADZVjLDwowhKDjVo08fBvXStABN8C3ZwWtshmRJVgWFsa
 XBqQYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsujxdhj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:37:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-943e8ff02d0so57849185a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 00:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794213423; x=1794818223;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8XtxpwepNLFe4At2B+OUT9XResQf2iFVDrkaX3oWwYA=;
 b=eUCJuDga0w9u2LizevNsbfwUqvONyJmQYtET5vQ6Nz02piudDOE57FK16yCACJcvrj
 +/doqVcwdxs3dHCmxOjdttHm08J5zApaBWRyQOguUkIjpeT6AHq6rTQPqk1YL9HvX+kH
 5y+uaF5AI/v/9Juqb/qr/KeBntRP11ERJO+bNi2GzVHgzaH6C+sr3QvAhIuPjQUpHix/
 PZybQnI/sDyxrBbl3e6ssHo+/L/cB40RMfhVBe0BB/Xz7zMv/L/lsKBslnAkgcxTKPMP
 raESLbXUAhtRfCkvvCJnkdTsUqomxjUzxq4ctePGFFSgJrjHQ5XWYshALyTk1tl6wt3p
 +DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213423; x=1794818223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8XtxpwepNLFe4At2B+OUT9XResQf2iFVDrkaX3oWwYA=;
 b=1fF0fBxmOwq2cBkJSfDB1VhETLgnCu6VgzUIY84E7CIcd7qqoFJkS4HjkZMaF98NH4
 rNxqG3n67lpiM/7NVmAfqqznXknjFY12Aph7pWvJtnhBKBVXNhhZ/5AXxHzKZA6Jw0dl
 R8sv/1v7bBSXoAhfaDhxSMvyANMHNS4pGZU8tRngdMRTBeWtTOpL+HehUHG4eBx7xoFp
 CR6SFx+9pcEozSAH4dqTqMX9ZqineIt+3T+wqbb3668gMgv8hAN9jjipdNLz5h+G/gBd
 1gYVFDSnUuSMAoAGZqa8IQmdXRyuRl6E/LQ75p6Ug+QteZjHy3hnNznCcWhuaHG0GH8G
 eKuA==
X-Forwarded-Encrypted: i=1;
 AL+hErGrV7Wn5JJ/kxdmw3siOhKokOf6FfC1rASJfED6JuNJ3feljtJMr/Ixvb7v0c9T0FAoEZLNzjz6k0Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8g3jcCDp9DJWglltO6tbVc58mnAAmCw4t4B94QrV2UBwmeBRZD
 1EcEgufCFRzPoM0b5/2dfV3ZMdmqclqJXOMPAIm7sNkcFUWpslDGG/rGWwWDLqymfIuSkPpBoha
 Qh2QuZaOjpvlprRCk1b3pRo9y5HGXXwmXwX4oB6NYncCAp1mG3xmboPlBlZHYpBKup1GjAnA=
X-Gm-Gg: AYBFou2nmGRcxuvEGoFZTLFnrzAZETYFhEkM15n7/VcZX0yJ0yqTXg7gWzTbfszKKKT
 W8Qr6ZyIXCgNhTkCmaELsSbBvKQCRtPajyttLpEQDKXYfJdx2jL6HwYLLYXWAFkHqasjQwG8Vnm
 xK24gFc0EdrSXNGf7DJhsMRxEEMs4uRL15/tfPD5oyA6nGO3MQJQdpxyzJ7Wt38HYPWWg6fvzZj
 WaC+52to98CqJtoAz4E4J9o5o8se98r9mgmzKGzfEhUQ+ruB7Tldm0L4+eUIUm0ZsbC8hFdHkrh
 XPOTJgfH+ePFROlc0h+p2OJtCJi83qFsipG76JHoRan8CGWnKmLWaFSBn4aUNetHDd1H8k8+5z9
 IyOqdTK/H/nZWH5MARoi27oEzB2p6mBr39I5qM0GrBOxF8tGTRzwXtRGKxRo5jpC36xlSrPAMnU
 8VLKZZ5FCqKkyqFDrWEuGInmQmqMvEbUtLidM=
X-Received: by 2002:a05:620a:a986:20b0:947:920d:3408 with SMTP id
 af79cd13be357-947920d3502mr120148485a.46.1794213423291; 
 Mon, 09 Nov 2026 00:37:03 -0800 (PST)
X-Received: by 2002:a05:620a:a986:20b0:947:920d:3408 with SMTP id
 af79cd13be357-947920d3502mr120146985a.46.1794213422839; 
 Mon, 09 Nov 2026 00:37:02 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94782dc37e5sm418223385a.34.2026.11.09.00.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:37:02 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 16:36:36 +0800
Subject: [PATCH v5 2/3] drm/msm/dpu: Attach CORE and INT2 power domains on
 Kaanapali
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-msm_gdsc2-v5-2-4a3159b5e4b8@oss.qualcomm.com>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
In-Reply-To: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794213397; l=2690;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=k4/w0ByaTXPXsf61RAe4GLz/Jc50aw9jLRjtqxw+Tis=;
 b=jm/6dNLOk9BQB6T4YigYCRGN5rjJDhn5xVlksn8EDet1BPVk3o/WxOyDPoNbrLiVSarhzbAZL
 DRv1xuJkC0MCjBgjnFntvfBf23OQYChfU4yNnGqvGROfVkRJOaa72Qr
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: Do5UQ9HySVLOJC7QVZg7kydE9XRhipFT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX4OYrvJ6juyA8
 K7RBKn87hvw8EVDJMWAavVmBVKLX7mbAh0E4EVn3msv6OwAorLDg+2vvfrF/HL6zXBtlkQhuexu
 LtBAE2BIE4vscfuVcWn/HUBWBKmpd3hH0cfKUa0Y2BZw49DjY8CT9lG4pk+5l3ZKTpErUdUFrmd
 PlIxeoYIj9kTeyLL89UY6WQaq6Vo0MDYaECMZF3BZBTC1nmTRdP7Y/Oux/gTTJv6v0KJu0IL+1e
 YbqJ/ZM5877qUHv2TZyT61KHtkN4CnaqRApTIm0VGtricwgAZUuv4RwhSI8ng5hayvVl+zkS+ZK
 J9L+udGNRfc8QYUIRtTEaON75AYnlcXMZM6KfFw2w/yPA1mcE5VwL96UDIK7kP5xJR/7D+QxpQ9
 x8VlXAReySl28xinwYP4wKtOSc11ahU5aUVkf4emalzH2Ext8wblJ0+dBGkTetoqf3MP5n1n4QB
 r+M4gdTvbrZJyOsJhrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX2EWQlSm1/5mH
 R87dQOecATkf14TX09PBXcRukwFHgs7qLguRNTpx2ZS5qMwycKaLVzHbnBuDBsSXVl3MKU0KeHE
 93JV2QQo88W2QNaUx3lhK3YeqEidCYg=
X-Authority-Analysis: v=2.4 cv=TeIDJhQh c=1 sm=1 tr=0 ts=6af1862f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=hNyr2f_ZztDnRCZExOcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Do5UQ9HySVLOJC7QVZg7kydE9XRhipFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090034
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

Kaanapali's DPU is supplied by both CORE and INT2 GDSCs. The
power-domain core only auto-attaches a single domain; with multiple
domains the device is left unattached, so both domains must be attached
explicitly.

The DPU OPP table also needs to continue controlling the MMCX
performance state. Mark CORE as the required OPP domain so its vote is
propagated through the genpd hierarchy to MMCX. INT2 has no OPP of its
own and is attached as a regular runtime-PM supplier.

Platforms with a single power domain remain unaffected and continue to
use the existing automatic attachment.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Joonhoe Kim <26rote@gmail.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc2..502e50ea5acac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/dma-buf.h>
 #include <linux/of_irq.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 
 #include <drm/drm_crtc.h>
@@ -1376,6 +1377,33 @@ static int dpu_kms_mmap_dpu(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
+static int dpu_kms_attach_power_domains(struct device *dev)
+{
+	static const char * const core_names[] = { "core" };
+	static const char * const int2_names[] = { "int2" };
+	const struct dev_pm_domain_attach_data core_pd = {
+		.pd_names = core_names,
+		.num_pd_names = ARRAY_SIZE(core_names),
+		.pd_flags = PD_FLAG_REQUIRED_OPP,
+	};
+	const struct dev_pm_domain_attach_data int2_pd = {
+		.pd_names = int2_names,
+		.num_pd_names = ARRAY_SIZE(int2_names),
+	};
+	struct dev_pm_domain_list *core_list, *int2_list;
+	int ret;
+
+	if (of_count_phandle_with_args(dev->of_node, "power-domains",
+				       "#power-domain-cells") <= 1)
+		return 0;
+
+	ret = devm_pm_domain_attach_list(dev, &core_pd, &core_list);
+	if (ret < 0)
+		return ret;
+
+	return devm_pm_domain_attach_list(dev, &int2_pd, &int2_list);
+}
+
 static int dpu_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1392,6 +1420,10 @@ static int dpu_dev_probe(struct platform_device *pdev)
 
 	dpu_kms->pdev = pdev;
 
+	ret = dpu_kms_attach_power_domains(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to attach power domains\n");
+
 	ret = devm_pm_opp_set_clkname(dev, "core");
 	if (ret)
 		return ret;

-- 
2.43.0


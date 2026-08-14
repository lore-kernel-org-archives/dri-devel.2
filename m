Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FFEC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D24810E230;
	Fri, 14 Aug 2026 16:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+jO8Xqo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AX437oji";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A850110E230
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:41:29 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EFvR0a1771357
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=FLl5j633yGnhRW4yq74ExUx3+uVkWVFtDN+
 vWUXMeBc=; b=D+jO8XqouvbmqKwDUFyXCNmJLIklptwk2tuYTZ2O1JGS3MKICqT
 6b0/4rVoFlLtCfn4i+OwNqREBwPzW62rw/my5rYzus4jcgsDJykFmp08vz1odRjD
 6uyqmIcdc9xX2eQdF1mG/c+Ec6uRQngmRpjiDsFrE4nmjke5xKUaa6f0AQZfQDaD
 8fLTsOZAYHw5VNm+lg34BNFmjAImYjf4Cd7OE0hr/9ppSxIu0vmOlMEJ2ReKxH+T
 NaPqaN9Kyfug3W80y0otefWPPYvbOL+e27b2phVR1uKQh80erfGmZdGVhDPqkyKt
 VH1S4YqM+Oq6vfN/uRatw4pWaXItBcdqhBw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g264506wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:41:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5283df62d68so15009321cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786725688; x=1787330488;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FLl5j633yGnhRW4yq74ExUx3+uVkWVFtDN+vWUXMeBc=;
 b=AX437ojinKUOwSth++vwAZ307TsvpLytL1BU9VKA1jZo6sIMiqZXS+llP0RvwWOUQr
 /Xq137fgXoJqFTj1tmJnh58F260FkbZ0XRkpGMABB3LTHsQIJAadxfZhyzfZYrBF2Hev
 XhLMLhdpa9WOQ5HA1rZiXQLXX67NWt0qJd24s0asU7YqOYcWf8daINSiP2QJljjCdGgP
 HxkoakGVf1smYB0Wgl2FWXZoHCl+Im8bprDMHTZPhZoIMtL4/qdgU/5W6VZwgpLhO8n+
 qxhcfRONACBWJcBFGFY/c0dIUehTue/snbZCo/xh+/+mqb69aQ4uAdefOAI4BkC7f5fg
 0ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786725688; x=1787330488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FLl5j633yGnhRW4yq74ExUx3+uVkWVFtDN+vWUXMeBc=;
 b=Xoatgdq3WTAXIDuQzWnziMcL5HqdNqRjOztIa+l3KK0hl/pa8QbzKC+fJ231/5+oFS
 cgPyuQPy7AgvwOxBe9fsJP+k+DSh+hiKP4dIHBr5At0fCbfFx/EnXYPA38LO+At3hkeK
 raVtp+593XIaTksQ+r1vj+Ll4vqAI4kksPRKusq+IrjAPLRxGZrSkRueb7yZgO22FBY4
 8vwdEc85tPvSPNLj3h/DuFTCtY8OfT5Q+xyjRjrg+XnD7dntOcjpOWrPB7MkhZ2BqJLv
 NygV1uzw1GR26A18v7p1Y/1WPmzEyNvpFd+BEHsZBP2A9XmbwENLjmJPCtJefh6PBrKg
 gKjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RocU0REMBnV/TN3PcQN1QeRAE7akgfFP04amiKnS9lNAVQj+cHhyr+4X7TLWR2lUO/YzSzPcD/Ii2U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdRffdpXKxGct+0ni5P2mSEyb+ASXSm79aVwcQNn8cYuJFdVLb
 oY77FwhJW3cgCmEkcKi8aD2YcfOAOzRcSJwI5tRqJOCiJ6iMXBoLqtjfKehKKYdxpVcPQTEz2Km
 Yyn7SXiOPF2uzyUBHI00zRj0IMhqxcH8MkbH0VXa3kYSIe5ftbBv1s+hb2jfWvpbYcr9UfCM=
X-Gm-Gg: AR+sD13m8YC2TqITcF9+/YFfI5VBLsTAqxQZBj/6iNu2Ow4fu8yJF5c3nSeejlTjlCn
 5gDuzikxZmt55FY8uEvNroYwO5rpuJp1ruu5gRSnUrxxcPnkRHQ2SrQsTL211IR5WAd4gpExvUK
 B5cxB4ih/wW3/3cvQ4Q7+U6Tx1XnGFzv/OIY2CtcPyYRB/F+cfu/rS+NcsPyecwN1eeFYLM3lnU
 9utU5YtJJxodre0a5/20QwiQawdvWHYvZcYdtJckwUcEoJA9LWj/QGVS3DwVrzvfMp4/qng7ADi
 F0HS4ynOCVa8S0GSXhJfG/t+d3FLnlH3I2eB6H1Qmjgvzbk+SOifW17JJH6vwNXR/uGz2sMO2u/
 49x6iNZlGaWD7fsPAFHi5UD0xf9BLe9qhXfvBDlwH
X-Received: by 2002:a05:622a:1e13:b0:51c:6e:ef23 with SMTP id
 d75a77b69052e-52d8551d1d8mr90293741cf.32.1786725687893; 
 Fri, 14 Aug 2026 09:41:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1e13:b0:51c:6e:ef23 with SMTP id
 d75a77b69052e-52d8551d1d8mr90292781cf.32.1786725687335; 
 Fri, 14 Aug 2026 09:41:27 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21234b7467sm128309366b.15.2026.08.14.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 09:41:25 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Troy Hanson <thanson@qti.qualcomm.com>
Subject: [PATCH] accel/qaic: Add support for AI200 virtual functions
Date: Fri, 14 Aug 2026 18:41:25 +0200
Message-ID: <20260814164125.3652876-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hPXrwENsawIOwGv1yYF3h_ggrsvaHQVA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNyBTYWx0ZWRfX0yMmNtSoMHuF
 mWN5ocV/KcGkGKBkTv8gGD8IJpa9b/BxP8xP6O2krKselURaJCDYTRUQvtYtH+JWCEk/4KMsgN/
 OOIl6FiJ8s9PtjqyfuuXQ/aAc/kmwvY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNyBTYWx0ZWRfX4xwyvoccyiXj
 rw8xwtG3JhGh/+dYTAO9fS8Ba4nEBlx7HMRDmzDecrWFo0ATDkl9XJJnTjk5MSR+25vesZK2VNS
 ym9tJD6L7EpuDivt0b7eQPpfEoRGQ82NR4dE07fycFo7gkKdQhYfYHZWiH623cHgTKCWsCLRcVb
 D64uvRcpui7FvRM8TdZNq45kaFeBk/wPWnOj7EY79hRsxX9T6P5ucVZLvJBGh2Jz6W8Ww3qRH4q
 pEfPSuValAdWUe4v5ETpI8l4MBp+Qpez/m1dppfgC0eNGPB8BrkUyhHBrC3FKwq3soHAEMa4Wh7
 HztQDYij0RSwCfXIlq3lEkRhnlV8i/5/sBmgawova+LYDj9ewngnGUn1LRE7KXOrpvekzqON8Yr
 Po0E3V4crBC7bq2ZONLr6OaSKxIedCDcAkHKqISoeDwkrNt7hgUovUebjEoA7ojSQ+Nwv4trESY
 i3wQJF+xH4Rya8vGjFw==
X-Proofpoint-ORIG-GUID: hPXrwENsawIOwGv1yYF3h_ggrsvaHQVA
X-Authority-Analysis: v=2.4 cv=OamoyBTY c=1 sm=1 tr=0 ts=6a7f4539 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=OXodVWOEbbvTmevkwmwA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140127
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

Register the qaic_pci_sriov_configure callback to allow VFs to be
created through AIC200's sysfs numvfs entry. Additionally, define
a new MHI family for the 5 channels supported by AIC200 VFs: NNC,
Telemetry, IPCR, Loopback, and SSR.

Co-developed-by: Troy Hanson <thanson@qti.qualcomm.com>
Signed-off-by: Troy Hanson <thanson@qti.qualcomm.com>
Signed-off-by: Zack McKevitt <zmckevit@qti.qualcomm.com>
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/mhi_controller.c | 192 +++++++++++++++++++++++++++-
 drivers/accel/qaic/qaic.h           |   1 +
 drivers/accel/qaic/qaic_drv.c       |  36 ++++++
 3 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 40e6d262ef21..c720b70b1e0f 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -23,6 +23,7 @@ MODULE_PARM_DESC(mhi_timeout_ms, "MHI controller timeout value");
 static const char *fw_image_paths[FAMILY_MAX] = {
 	[FAMILY_AIC100] = "qcom/aic100/sbl.bin",
 	[FAMILY_AIC200] = "qcom/aic200/sbl.bin",
+	[FAMILY_AIC200_VF] = NULL,
 };
 
 static const struct mhi_channel_config aic100_channels[] = {
@@ -691,6 +692,159 @@ static const struct mhi_channel_config aic200_channels[] = {
 	},
 };
 
+static const struct mhi_channel_config aic200vf_channels[] = {
+	{
+		.name = "QAIC_LOOPBACK",
+		.num = 0,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "QAIC_LOOPBACK",
+		.num = 1,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "QAIC_SSR",
+		.num = 6,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "QAIC_SSR",
+		.num = 7,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "QAIC_CONTROL",
+		.num = 10,
+		.num_elements = 128,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "QAIC_CONTROL",
+		.num = 11,
+		.num_elements = 128,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "QAIC_TELEMETRY",
+		.num = 16,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "QAIC_TELEMETRY",
+		.num = 17,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "IPCR",
+		.num = 24,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_TO_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+	{
+		.name = "IPCR",
+		.num = 25,
+		.num_elements = 32,
+		.local_elements = 0,
+		.event_ring = 0,
+		.dir = DMA_FROM_DEVICE,
+		.ee_mask = MHI_CH_EE_AMSS,
+		.pollcfg = 0,
+		.doorbell = MHI_DB_BRST_DISABLE,
+		.lpm_notify = false,
+		.offload_channel = false,
+		.doorbell_mode_switch = false,
+		.wake_capable = false,
+	},
+};
+
 static struct mhi_event_config aic100_events[] = {
 	{
 		.num_elements = 32,
@@ -721,6 +875,21 @@ static struct mhi_event_config aic200_events[] = {
 	},
 };
 
+static struct mhi_event_config aic200vf_events[] = {
+	{
+		.num_elements = 32,
+		.irq_moderation_ms = 0,
+		.irq = 0,
+		.channel = U32_MAX,
+		.priority = 1,
+		.mode = MHI_DB_BRST_DISABLE,
+		.data_type = MHI_ER_CTRL,
+		.hardware_event = false,
+		.client_managed = false,
+		.offload_channel = false,
+	},
+};
+
 static struct mhi_controller_config mhi_cntrl_configs[] = {
 	[FAMILY_AIC100] = {
 		.max_channels = 128,
@@ -744,6 +913,17 @@ static struct mhi_controller_config mhi_cntrl_configs[] = {
 		.use_bounce_buf = false,
 		.m2_no_db = false,
 	},
+	[FAMILY_AIC200_VF] = {
+		.max_channels = 128,
+		.timeout_ms = 0, /* controlled by mhi_timeout */
+		.buf_len = 0,
+		.num_channels = ARRAY_SIZE(aic200vf_channels),
+		.ch_cfg = aic200vf_channels,
+		.num_events = ARRAY_SIZE(aic200vf_events),
+		.event_cfg = aic200vf_events,
+		.use_bounce_buf = false,
+		.m2_no_db = false,
+	},
 };
 
 static int mhi_read_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr, u32 *out)
@@ -864,11 +1044,19 @@ struct mhi_controller *qaic_mhi_register_controller(struct pci_dev *pci_dev, voi
 
 	mhi_cntrl->fw_image = fw_image_paths[family];
 
-	if (family == FAMILY_AIC200) {
+	switch (family) {
+	case FAMILY_AIC200:
 		mhi_cntrl->name = "AIC200";
 		mhi_cntrl->seg_len = SZ_512K;
-	} else {
+		break;
+	case FAMILY_AIC200_VF:
+		mhi_cntrl->name = "AIC200_VF";
+		break;
+	case FAMILY_AIC100:
 		mhi_cntrl->name = "AIC100";
+		break;
+	default:
+		mhi_cntrl->name = NULL;
 	}
 
 	/* use latest configured timeout */
diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
index 02ca99000e2a..889fa51da7da 100644
--- a/drivers/accel/qaic/qaic.h
+++ b/drivers/accel/qaic/qaic.h
@@ -35,6 +35,7 @@
 enum aic_families {
 	FAMILY_AIC100,
 	FAMILY_AIC200,
+	FAMILY_AIC200_VF,
 	FAMILY_MAX,
 };
 
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 0acf6cdd44f8..cde8eb8c7a71 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -77,6 +77,13 @@ static const struct qaic_device_config aic200_config = {
 	.dbc_bar_idx = 2,
 };
 
+static const struct qaic_device_config aic200vf_config = {
+	.family = FAMILY_AIC200_VF,
+	.bar_mask = BIT(0) | BIT(1) | BIT(2) | BIT(4),
+	.mhi_bar_idx = 1,
+	.dbc_bar_idx = 2,
+};
+
 bool datapath_polling;
 module_param(datapath_polling, bool, 0400);
 MODULE_PARM_DESC(datapath_polling, "Operate the datapath in polling mode");
@@ -761,6 +768,34 @@ static const struct dev_pm_ops qaic_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(qaic_pm_suspend, qaic_pm_resume)
 };
 
+static int qaic_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct qaic_device *qdev = pci_get_drvdata(pdev);
+	int ret;
+
+	/* Qaic device must be online to process VF bringup */
+	if (qdev->dev_state == QAIC_OFFLINE)
+		return -ENODEV;
+
+	if (qdev->dev_state == QAIC_BOOT)
+		return -EBUSY;
+
+	if (num_vfs == 0) {
+		pci_disable_sriov(pdev);
+		return 0;
+	}
+
+	ret = pci_enable_sriov(pdev, num_vfs);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable SR-IOV: %d (requested %d VFs, max %d)\n",
+			ret, num_vfs, pci_sriov_get_totalvfs(pdev));
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "Successfully enabled %d VFs\n", num_vfs);
+	return num_vfs;
+}
+
 static struct pci_driver qaic_pci_driver = {
 	.name = QAIC_NAME,
 	.id_table = qaic_ids,
@@ -768,6 +803,7 @@ static struct pci_driver qaic_pci_driver = {
 	.remove = qaic_pci_remove,
 	.shutdown = qaic_pci_shutdown,
 	.err_handler = &qaic_pci_err_handler,
+	.sriov_configure = qaic_pci_sriov_configure,
 	.driver = {
 		.pm = pm_sleep_ptr(&qaic_pm_ops),
 	},
-- 
2.43.0


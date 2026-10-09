Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D4CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09F910FEE0;
	Fri,  9 Oct 2026 06:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="GV5U7pb8";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8A410FEE0
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529051; bh=8RrG7uKCjNj6/30H7hH0KNj6Yb6WBqBxBhbi8qPF3Ck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=GV5U7pb8pISeU6Q18eKWvN6pWUJ4r4OHShDIaNV7Gje8M2R+3dw+dhGuZkea1jd72W4mvpYRT9wlQTnXSfOTuLN+S81FbDHEnjFmC6a4j1/8cUnj0Z27xaLb5foove7b4dDP+/Xe8Lo+N6pegq5CKY43J6qDoKjuSMp/mDT1y3BgMCRy5l6jOhAECCMWqv1FF5vWNuywtIzeZY6QbzDX2z0vnk3+ba8HTGL5+i49tdp+9nK4TKBQjTQb3oQvMwZ5onaMUwNKftj66oT0xNKLvWSWZsnjCOqgoPmzXYSbsu/4kpd+BCCUjjXELQ0PHCIIv0XzBVDSQEClU7dZ/fIiyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529051; bh=IaoeyP8kopTt5YgQyEvIKb7okCNC2ZnhTtBUxi5iuXb=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=czAaFYg6oJpzluUhskClQ5yR76RyhCN9957AH9wLr84kHrC8PeSnKBtCZFhd2drhL+2g5IilrR/LIMNANjDPLDhQ+Foyq/nzn8WfV9H1hw6smTAO6b9dc2jhWzVXUkY6pjT41uqSneLU9B/HMyx7XaSEwWMDpSWfGiUuAs8elQvMwGpZlnnp6sgMeVZTwKMvx/qYDJV01Y0wZ4z+m51c4WqzknO9HUIvkmrcM6F815AS3CPcH4sMLf1m6+B6gSLqJlF4s85cEnGTAmcbVBIkgCWAACltLDOdRLgP+34BW/y7m25cLrMGTPKPipNV7onQcKYKoVSQaHjIQI1LTM10CA==
X-YMail-OSG: iHUIXK4VM1kqCAdPE8Odph7CTEAw3hgpAOrmxXSY9UvJytCpPiQSjvmHUGO2Ims
 XBGirvMdOYS31GirqZXBtVYICgidPeNkndAftZoKx3c_WAJew5.7gej14UClLQdgEfA81mqGlFMo
 .VAy.qH5qnUnFN4e054JpN4AXFnb0QFpm8x0VJYwJeg1GwzJYPvVqlx63aEIWIoBD9vm6GZkEd9N
 Cjy1hCIt87u1Mb01Mf._Fwa4fWS1u6CTIGvwrJu9i2K85.mDKBNIX2gaXw5CQoKpMMfwW8tk1GDx
 5lXhjDQwqc8YuoadnUkdN.xGu_YsyH3APEXIQMLEpQbq1cp_WjX3Xu_kIlwRPgOz9lR50kA2q9_T
 ldbDpF2dF9xXGVmxQEj22pS1pVZoe81PV.PbOcwZ3eU_2RxCMD5M8nhBnx0uFXiOS0tH35Mf1zfq
 NRGWDZ2KO8MqP865mcL.jZ5ETftpax__mJ40sHBRdx4GhfCOla5Njen4m6CKcPHwzxmBaTEE_0Az
 b0nBvoiEiL8PNxNdnsDMhcjWF0wbEteLDBwHC5wXFSJNAt9SLr18kbUYtxTCDDucVfWFRZmxJXQM
 yBEEbTVO71AiAdhSy8HgBe96su2EHIjK7mX9kFVr97olZq.s9KB5IslBt_py8s109WkuN_y6EsJj
 kLdZmjTf6mBIZ_eRXCQjRBzocRSKkJR7Wh4m1ZHKk.BrsZsx_JfGUBfGQLXNecNOGsUywfkU3_0b
 tqZ8I5lULiPOtJSyNb8KpUZxm2zckOhcLv6Y7IEA8_CshXTNebpMRA.fgdMVa_P94n48wan.qL_E
 _gyjPRb1gJcJM6aTLSkuojNE_0yd4MbbREYB4jqjQVZebsidn4G8diFlYTL2C1Vqat5144tgIuFE
 UWwGvrevKBGeXHqap1fHezMJRQoRTYWoQ9RfKngycR.7Pc6jP3iW05QC40HOdc3_elYx9HZ3RyLD
 DwNvfpcAmVuPpTpupGwTyVkCzTFo1Sr_hu2ni6XvBG0VsS0.5UT9RSWXIaBuqVC0YiCpqHAeBock
 _Jf329mQ8cqJ4QpvspT7iL8SXcbhvi6BTzRP_DLnL.aeayFGkrg0VHE.liNWcMQ..OJ3XozyiBBt
 fJ9I0xxGefVtLPsrzU_me.Xq1rEDjjtQkDDOpshahWZTGs5i530PZ0Gltbjgvm5JHmlGuo0ehrQu
 qQ9VHuXKub4YxPJ9s4BlcjboFrZD05_u4xjd4skgJeTnin_ggcEXSxJl_X.lieXNGzr2lcDiulkQ
 VtF4sK5XnB9gMYjCLDFeieIRNIKPkUTxxMrHMfRHXPPcSS4oqQ9jZiFMKH6QgshsVEAPK0IHgBNZ
 ZkRtDXW1naPJ_VqsSeOclRDbShniipl3hwJXDvjAQQr9gMo3S1eCQqD.nZUEmmpjBqR8NNb3sT7U
 0l9iVpf9X9I9ki7nI4XE9NRmX0hiEVuHLekRVUshfENb.xPIUHCzutBkURKkSfKr2Vz2zWVrOiSM
 orwB7g6kr7EHalxFfrdVgKWeWC_Tdy7Ixble2L2d5AANVEc_iph31XgRdfw8I_zuEH2egYxAzJ1N
 k31AMgnPmVG11gRtaXyZoHqhWt4bHg4ug8ihiHfbBqPPcDK0mKcln.8A8L3n.FMCDbl3WSjzpBgT
 Xt6tttcIk9EhbkZIuVjIWJnYKC1iP4sk_Cb16IHtVrnteB.bKF_bp9s33cBk1GkuOtnXhbLURlJX
 SH0Gap3KfzOYmkMDzgCS7T6JZLWIvrQExyvezw1qiJUVCNGQthOMdPSgQuHINa.JLJ_V00Oy2Tk2
 U93yOWA6zx3G1LcfHazLZY8CBmq.KUEv.XRTkVEDfInyJT5Pki_hPItP3p97gT3xJXjbBR.TX5Y4
 wCR3rby6XzgwpKC1Z1vyloSGh8nJtelsqiqfTmFI3YQa19ldpo2MkTsHJC6hgnDNhnPNd39l1r_R
 DovvqJYmxyo_2nm69mNgXaPBzijSREfyWqvFcUboAxRnFmMIjubpyFEhEoRC3QkK4aiBLEOkWIaB
 3aJHK7AvOoWpHwAtkICN77UTtkDCocZ8r_gbYpPmN7b63ioz7sw--
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: ea792342-074d-412b-8a33-005bc3953baa
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Fri, 9 Oct 2026 06:57:31 +0000
Received: from dip50.lsn.bf1.yahoo.com ([67.195.177.59])
 by hello (SMTP) with SMTP ID b3167286102b6170239c905eac2e5892;
 Fri, 09 Oct 2026 06:57:27 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] drm/vkms: Allow stereo modes
Date: Fri, 09 Oct 2026 03:57:23 -0300
Message-ID: <179152904367.1726604.12494070896318807562@yahoo.com>
In-Reply-To: <179152903254.1726604.8785647683993800694@yahoo.com>
References: <179152903254.1726604.8785647683993800694@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailer: WebService/1.1.26668
 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo
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

With an EDID whose HDMI Vendor-Specific Data Block declares 3D (HDMI
1.4b), the EDID parser lists frame packing, top-and-bottom and side by
side (half) modes, but the probe helper drops them with MODE_NO_STEREO
because VKMS never sets stereo_allowed. The composer and the writeback
connector handle the frame of both eyes now, so allow stereo modes on
every VKMS connector, static or hot-added, as i915, nouveau and vc4 do
on HDMI.

Connectors without an EDID are unchanged: drm_add_modes_noedid() adds
no stereo mode.

Assisted-by: LLM
Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 08e1828a0f..3449c4c213 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -194,6 +194,8 @@ static int __must_check vkms_connector_init(struct vkms_connector *connector,
 {
 	int ret = 0;
 
+	connector->base.stereo_allowed = true;
+
 	if (vkms_config_connector_get_supported_colorspaces(connector_cfg)) {
 		if (connector_cfg->type == DRM_MODE_CONNECTOR_HDMIA) {
 			ret = drm_mode_create_hdmi_colorspace_property(&connector->base,

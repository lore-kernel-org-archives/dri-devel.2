Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271F606A68F
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iXrRu/iI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBF310E5F8;
	Sat, 21 Nov 2026 00:57:36 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CE510E5F8;
 Sat, 21 Nov 2026 00:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795222648; bh=TPbSSBsUi2FPMV8cJCQywObSZ6y/voEbnjw2p85Fphc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iXrRu/iIbZT6sLmzaOjBNCTE3kZvSObMLNWYc8afVf1U+19eB2KTRDrmwapqieRPF
 nfutyymh0RcBv5ya2K6O1731I0MRegziDRR7RBE7BpBuOGGzL1TQAxzapoH32Yba8h
 6xYPHIV4gHJKkSlxjJyFSKmZqStu9PdeJLYgNH7E=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id D8985C1C; Sat, 21 Nov 2026 08:54:09 +0800
X-QQ-mid: xmsmtpt1795222455tecjyrmpy
Message-ID: <tencent_10977788255152703A88096844DFF3EF9D06@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznkAvcKrMmoPcxBguY6e7qBGYnwfk7sv4oidxWRtcm8mySV1QYu1
 0ntbnTfDkzsEQXBuGoqNmk5dpJiKWYXpgd1AceQldffgkIsS27hgfg+k9az/tzptqhDYT4QdVpBb
 qryByBj1sIltTO30PHZq82VZ0WrTXWDziHjPCrkhhlTfWKDO58EWXxgAYV3auCVdhY109APdksrs
 CEZem3UzX2a4IQzwQlMrul43Cueun0MpQ6tfQvdsS8s5lPT6wffP6EQGvSUDUldJDJE6LjlgQTfd
 Ff+1wTrO/X8NNwyH4m+wtj7zu03edzhPtQb5f5d/nORo0pydMBsVAzKnXics5cvFfJgE99chZ5Y4
 ZGI3C23+FntETj1ZFU00c3ONAifhvEkbNBItybPJTqRjZk/PJNrmFsyXXbSVJ6qkh/VweWT0t7QK
 M2SRgbux7GdEWIKHaflJ9DjATh1qBj2hAam6NDE1WtoMjFzKFCh0SkadONFJ/pepTPKqoO0r9l55
 rmjthrwlddvD1cU+ucAMlEwyCG79v6ghC4oKjH0olwaBvJSPZKvYmCwTQjgqNOxRHJNzDhCxrzE9
 pPAm8olxc6AA8LahPTlGQtnliSEdcLm3WCopNK5Jn8ZzE+OINOeH4XnQ2/mfqdnymJeClBAIeqgb
 TbpiwTEnmPqjPTJVZ5grR2Z32z6MrPvDw7ZNvj6L7NRK+FW6QCIl3PgGhbRIKvoMwSUuUXuIjCe9
 BdHdlOOkDCYqp+4zhuN+ck9ORyurhJgK/YjkiLNGYvxBuSDlA1zsQWMIagBO9YeX2caoxHIWSS9z
 5BR0sDpJpnziRktJn53u70nyQPYjh4gLefov4adYCbsMXtaVadu4TN2Ay+EsGHhqLL8PTmVD6AWl
 pxf2LPH0IkEghOAywU0e5wW4QS56e28e7hrKd/Zf8wf5Pa3p508oDD4SZW6gy6iHZ43M8vnWP0Bx
 NQzUt3/eANQHQu9gV2FqDkT6+C2AUWnni5iivgoXs704WBQHTIrJruiLkhTLuZGKI1LQ3rvDMVA/
 sqOIsQY/bFnZkNAgQEN16mbHDszgbP8p46bsZ1Kg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v3 4/4] drm/i915/dp: Prefer SDP over DPCD for HDR content
 luminance
Date: Sat, 21 Nov 2026 08:54:09 +0800
X-OQ-MSGID: <20261121005409.17626-5-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121005409.17626-1-fighters390@qq.com>
References: <20261121005409.17626-1-fighters390@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_dp_aux_write_content_luminance() skips the DPCD write when the
encoder cannot send a gamut metadata SDP. That is backwards: the DPCD
register is exactly what the AUX HDR interface uses on those platforms,
while the SDP takes precedence where it is available.

Invert the check.

Signed-off-by: Yitian Shao <fighters390@qq.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 8c7fd99..92516f3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -250,7 +250,11 @@ intel_dp_aux_write_content_luminance(struct intel_connector *connector,
 	int ret;
 	u8 buf[4];
 
-	if (!intel_dp_has_gamut_metadata_dip(connector->encoder))
+	/*
+	 * When the metadata is sent as a gamut metadata SDP it takes
+	 * precedence over the DPCD based content luminance.
+	 */
+	if (intel_dp_has_gamut_metadata_dip(connector->encoder))
 		return;
 
 	buf[0] = hdr_metadata->hdmi_metadata_type1.max_cll & 0xFF;
-- 
2.53.0


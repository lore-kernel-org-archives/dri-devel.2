Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F2606A6AB
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LJiKi9DQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F09A112DC6;
	Sat, 21 Nov 2026 01:36:03 +0000 (UTC)
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com
 [162.62.63.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F18A112DA5;
 Sat, 21 Nov 2026 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795224939; bh=R5OcJKIoc7UZ6SxitYvSiJSHe0rQIIL++UAR7CQCbQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LJiKi9DQ4x+XPqdvZjrIGRVIz6HaKqKeFn6ykhmr5Q7YRZPR3CSbTz2BxPsucPqEl
 X+zWy1/zpQLY14UNRPAyR3mWbVXqDud8CDyUA3bC1eSvYaI8qy8qZ1bbPv/HHi2uSR
 CV1M1LLkMUUerwT9UWGAnMWywdNRhQFFXPULxHkw=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 8E0AE630; Sat, 21 Nov 2026 09:35:32 +0800
X-QQ-mid: xmsmtpt1795224937t704repbg
Message-ID: <tencent_5DD43C77DFF979575A522595A58F9B40470A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XhLbaYAYHbTcjusKeBNI7wuQcKV6xFqgEZp2n8htWI3rFL3Hwmv
 g7EnlsfjMSGHjGqU8iKNpNofI1z404Tws7HH93WaVbZ61fQPPRQed1YQx7vQuoHQsqyENU+Ih3vG
 lcEoealQMKZFjydg2Peo1G0ZeBSq2sbDEoU6rmDD9nuaqY2Bc9ujHSgnB+XbcnS4HiMZHw4PdwZm
 gfCMGXjOm+GTDHKimYCcSMWGJBVNYcYW/UkURCGIDLOTwDJXGNojg/QusFUO6F+tKxYfYEqa6i3G
 2mK5pMg07wfc67tNEyoWkwG8OESbQXUU1sQUH7xseQD5Fx4kz/hHGjRk2PAByZzi1CGr2UASb0wW
 psd1M2N2lRN+YYg1OFHTteVkN9fc9UL2kxyWVBoKmaljeLG/ABkV7IVjIwpoZ++m96kzR2UfDAEG
 +RnlA3gpaJPALpxX7o1XZSgju+L8YS5CGU4u9jMw5sdyNYMqpl5LjPbvvmO7r4khWJS90UirsjLe
 0LTa7R6Mjztzbd4x0bcK9Sq9DHpNKKa5Y+OD0zkiIVfx3WHARgRSrXSWGoxTj1dJP6uAauWhB72t
 Hu8owbFDGuXkKp4M/pBgV+Tl+hQ/XMnxrp9SAt/+7PGuxUirAr8uPvpLbreIs5XW1p7lho0fhpAo
 tZO8ipFHEkeB63na8sNo9w5ehXfRTeMgnR6m+tab2rsyLMU5HtbYJWBS68+r6C0FumCFDQCOfwYr
 la7GZeByGRl2WPItPmUMQCe8Px74uU/8Q6fivgFaDfKFJQrAQDwGm9cEqz26UN5UewpkslfL4wRj
 uHZU7ta92SGGj/rwf9Y0PlrWGN1RJu72VM3mAUnJpQdPFnrN9EkiT3CleTUh9CmiR4wYa9fTCrfS
 iHsD0bnNO4/DIPuFBJE7zkPj/eYJHvuUmxowEseO8PV1A/3KWDzQYow6ra8Rvsdjob6W9aV1DxGZ
 eAhoq+2MZqC+yLtPmrjQxo8ZZCa4gbkhc2I9u+TSo8IDE9i+f+QQ7nkCqHQQ6WxS8xdem3IY5H5B
 Hq6fH3yAYtZqMTUUiv1DRgIHLkEROu+nMb3PJjqDpCjvcvCMWhgmXRldi3WBNjYFgXe8l1cvbTod
 VvXJsgJY4h0PManlxUgj6767LREOiA8RNqKbgD
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v4 3/4] drm/i915/display: Check gamut metadata DIP support in
 LSPCON HDR detection
Date: Sat, 21 Nov 2026 09:35:31 +0800
X-OQ-MSGID: <20261121013532.21135-4-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121013532.21135-1-fighters390@qq.com>
References: <20261121013532.21135-1-fighters390@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

intel_lspcon_detect_hdr_capability() asks the LSPCON whether it can do HDR,
but not whether the port can actually transmit the gamut metadata DIP. If
an LSPCON is hooked up to a port without that capability we would advertise
HDR support that cannot be delivered.

Refuse to claim HDR support in that case.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Yitian Shao <fighters390@qq.com>
---
 drivers/gpu/drm/i915/display/intel_lspcon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index 9ceabbc..797137d 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -137,6 +137,11 @@ bool intel_lspcon_detect_hdr_capability(struct intel_digital_port *dig_port)
 	u8 hdr_caps;
 	int ret;
 
+	if (!intel_dp_has_gamut_metadata_dip(&dig_port->base)) {
+		lspcon->hdr_supported = false;
+		return false;
+	}
+
 	ret = drm_dp_dpcd_read(&intel_dp->aux, get_hdr_status_reg(lspcon),
 			       &hdr_caps, 1);
 
-- 
2.53.0


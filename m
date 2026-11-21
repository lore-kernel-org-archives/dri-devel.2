Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D7606A6A0
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xVJnh34k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433B8112DA9;
	Sat, 21 Nov 2026 01:35:52 +0000 (UTC)
X-Greylist: delayed 2478 seconds by postgrey-1.36 at gabe;
 Sat, 21 Nov 2026 01:35:39 UTC
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com
 [162.62.63.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDB010E03E;
 Sat, 21 Nov 2026 01:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795224935; bh=M6sAFrpOGQij1moSwIRXm+zWaArygRB0HQwmNiSnD/w=;
 h=From:To:Cc:Subject:Date;
 b=xVJnh34kwRd2FEh/XyR70uuCKtt7wxFimxzCL8ZY1bQ/hHIuK00OW7uD6fW6LYo5S
 Cgsi+KSu284azUTpJEik/tAso5wTpn3UOnbDQZRnPScx9wRjfAbeIPuMK9VjhrgMNW
 3SoILyDGiTUR3694duBC7q8Nt9rFcQZRgAt6lPdU=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 8E0AE630; Sat, 21 Nov 2026 09:35:32 +0800
X-QQ-mid: xmsmtpt1795224932tbhikno96
Message-ID: <tencent_52DE9796124915E92B26E91110CF02777108@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLhoq3QDRTJ72VtrSaNzUuL/J2Oi1kEa4Ya0wl0jtydj7nb0NsON
 uZXmJZM/Urzcvj0SKwyNMG8Ta2IbmM9prt2+1HEuDhUWngc4WE7izDmJ7wh8Gp2mBI4oJzSckVcC
 koSFBnbpG3wfBCVo0POtamXMMjvEgDMAr7KTlZxd2Bp40NE+qBgeeyeX4Y3E5Bsuh9IuFlDssL2x
 vXWi8AaodQvHfNtx50PJi2QlDFayqPaxgU0Y17a8BkvPRVE1J4CQqEgqpB0x5rWbUL8Xl+9zt6CJ
 34itY/VAA00o9P7k1yTNHuVz+1P4oVm4zK15ve20gmPeqEuH1vY0BxzgV2VL/vMNAmBB2gQPLTWb
 /NlrZYhI/9fVKZSlyUJNMpzHOSIqp/o7e807jhAcA9L+T/V0/4vPt2ghed47y1DJz+ahLh/Kq0j+
 /965LvrBhj+GHJvxVNj9oHInU3BecpDD9LhYt4Y34eDeVyM3hVOIEpLqLo14eNXsGHQRKAAth5ui
 Vzo6bnqjsmgNUrAQy36FlS7MiTpkUKtuZyootb96p87u4596hU9jeQksIlzRtgqTstQgpAkWh91X
 Lb9L2LyIvJdY4nWSEdJixXCKPrPeNUhlO8I3oP4Q3rC9xZxavJzooJcLvK2UJnmP7TqoD07hWmEg
 /cW9f108TdN59pxkOuynyFog47aPjMoGEGQtjXapZo0tGApAhHcfXmo/8/dWVlPrmmDotiQ6qQWO
 L8vwzv/7xqbcT/QF9t2iiiku4wKApYE11A4ld5dJmR2ofDqxUbNl0YPuf9kyIgGGp5iJpxIE73Vd
 NEAhQQE/g5AEtk0PCPxQ+amYnS9GKubKRz4kxcYJsQD4NdA2/5emJD5GOK6AZ2KKxmNp56KVjTJ4
 v1miMQDoGQ9LfxE/MnZCLZJaxKiT2i/thMpRLyyh3zG2HmdYw19+/Db26bkwH1jukb8D7xvOUxX+
 mYhYR61UySR3Ekr9f7nkNSrb+8210L9TOZyEsJ3/SA7rpkffp9SC3r8QB/ju16FvEEY6QvmAJ2XE
 C648yMJTX1xSdmwugqmwA5Ag/9LBjA9PuYahiy+e/Q3eCbahjalaVoj6VAVHWawyXLQV7u0A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v4 0/4] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP
Date: Sat, 21 Nov 2026 09:35:28 +0800
X-OQ-MSGID: <20261121013532.21135-1-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series makes HDR work on pre-ICL eDP panels that decode the metadata
through the Intel AUX HDR interface instead of a gamut metadata DIP.

Patch 1 removes the LSPCON check from intel_dp_has_gamut_metadata_dip(),
which made the helper answer the wrong question.

Patch 2 attaches HDR_OUTPUT_METADATA on eDP when the panel's TCON advertises
PQ decoding, and skips the infoframe when no DIP is available.

Patch 3 refuses HDR support on an LSPCON whose port cannot transmit the
gamut metadata DIP.

Patch 4 writes the content luminance unconditionally.

v4:
 - Reword the patch 1 commit message: the gamut metadata DIP exists
   regardless of LSPCON; lspcon_write_infoframe() uses the same DIP.
 - Patch 4 drops the luminance check instead of inverting it, since
   INTEL_EDP_HDR_TCON_SDP_OVERRIDE_AUX already selects which value the
   TCON uses. This follows Ville's suggestion to always write the value.
 - Added the Reviewed-by tags.

v3:
 - Drop the LSPCON check from intel_dp_has_gamut_metadata_dip() and move it
   to intel_dp_add_properties().
 - Fold the checks into intel_dp_hdr_metadata_supported().
 - Add the LSPCON DIP check as a separate patch.
 - Dropped the fastset concern: HDR metadata fastset support needs a
   separate fix.

v2:
 - Do not skip the infoframe on LSPCON.
 - Only attach the property when the Intel AUX HDR backlight interface is in
   use, to avoid reading the untagged union.

Testing: CometLake-U (Gen9.5) laptop with a 3840x2160 10bpc eDP panel that
advertises BT2020 + ST2084. With v3 applied the connector exposes
HDR_OUTPUT_METADATA, GNOME 50 offers the HDR switch, the DP Colorspace
property switches to BT2020_RGB with eotf PQ, and a 4K HDR10 HEVC file plays
with VA-API while the output stays in BT2020/PQ. The TCON HDR backlight
interface was already in use before the change. v4 only removes a check in
patch 4, leaving that path unchanged.

Yitian Shao (4):
  drm/i915/dp: Drop LSPCON check from intel_dp_has_gamut_metadata_dip()
  drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP with TCON HDR support
  drm/i915/display: Check gamut metadata DIP support in LSPCON HDR
    detection
  drm/i915/dp: Always write the HDR content luminance

 drivers/gpu/drm/i915/display/intel_dp.c       | 32 ++++++++++++++++---
 .../drm/i915/display/intel_dp_aux_backlight.c |  8 +++--
 .../drm/i915/display/intel_dp_aux_backlight.h |  3 ++
 drivers/gpu/drm/i915/display/intel_lspcon.c   |  5 +++
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.53.0


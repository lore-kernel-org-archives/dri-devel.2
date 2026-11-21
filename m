Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A79606A6AA
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Txrot804
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830EA10E382;
	Sat, 21 Nov 2026 00:54:22 +0000 (UTC)
X-Greylist: delayed 68600 seconds by postgrey-1.36 at gabe;
 Sat, 21 Nov 2026 00:54:15 UTC
Received: from out203-205-221-249.mail.qq.com (out203-205-221-249.mail.qq.com
 [203.205.221.249])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3831E10E0D8;
 Sat, 21 Nov 2026 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795222452; bh=e/aC8ccbwdIG56wXxVOWgOWZtxpXoiQooiiDw3ou5ws=;
 h=From:To:Cc:Subject:Date;
 b=Txrot8046FW8hHV68U+KMgMpuKCMJms+q3YDKth8Dfj/c7osxbWayHAomEAY3yqT1
 /0gRY1pDxljbpilOV9hi4ZKL5gY/hYP3yqNtjsMlKJ1UN9P8l3KNu19tvoWw7aIIF5
 3NKgrfZQQWQdu0cSt2i1qWe462etTwpHUPGCYWvc=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id D8985C1C; Sat, 21 Nov 2026 08:54:09 +0800
X-QQ-mid: xmsmtpt1795222449tqubb4dbh
Message-ID: <tencent_D31B4BA3A4E1F42313C008AFE786BB6D6F07@qq.com>
X-QQ-XMAILINFO: NGZTnPyV/FemYDeKORaqLXqdbAPaD0nJKhKAViksjIxw/f7BENQIMsSbv77+PQ
 DGN1p6YIROusq85g3/ZZxihyLALBFmQsftjtWyj8o/eCHPN/Cgbk2jSnPHULZ3h/clZFKrEmPTGC
 RXhRUCwOvt9CurixFAskU6xyYeozLA76uIveEZeOqq//EDvlacj/DGFiT9x/Pzq73NEF9gVTKBsg
 XMCeGNvBVYvqEhAWa+fRDFT6Vnbeh34cSF4m4G/otAiY598U3XOD5T/K0LcZ2DgYaOZcMVevEU3h
 24WY7p33R8bLye9Q7GhvbYaukciE6PNaxbD4abr2ER4rRv92x9HJMIAa8VUTjCNiP7HiUYPeoF1E
 /4yMjGumnDgekNv9ToVeTy8Y42bpbzhSLb+SEk7x4U35gohgsC5HFvVBvYzkGaX6na5Dw+SPUlMj
 0xVGmJYrFHLL1oSZHeYuSkW23aw+wLanjA+DURjDrtc1O2NtSeKjBZpit4Yepoepu+n8SnWDWe84
 9u4krfjZjkIaKvgIFjH22xvVKqDIxp6zrmrbpBu8xd7QZweYO4Gbvl79Jxc8fAqS/FrfKsn1PQeA
 /3Fnfe1k371aBIEN/f35uELlDnf2Vr5NunXMkY4DmCOQqYQn1RmskiraDginWDlZ6d7aLvalMrcD
 Wq/40mz6OgYmXC8LeCv6CCEh+Im6X3ZDTFGnZ1I1oanNBRVl6FB5OhCcqolQG+bVTF+lRnhbvEjN
 LkpZtm4UKBRyQqh2DpalkdH0CVCMFoYmxTsufeRWqJbzQpLL9ZcoNhdzhQiuJbhL/NvxnqMPb3xX
 6BvLH66w6tzqLxytD/BV1HBV/aPPWpwWCDdsF/edOmYyyhR9nf/sysQMtFyzD+a/Oj4tMuAp+teE
 cIULP1LtczFIaCpTDdhwBS7tiXqH8nRF9yxDAoxkQkA0m+9RQPgElYPbh/z/3RHb/ilDH9NZpQyC
 REGAPVQ8ltLHrBrwdv13ZbaJXLJT3OUFGq+Q26lhRcLtXQHJJEqVz8M/7ksoHqmFxepO4fzCfOTp
 ZI7XX2zocCvgzQKrYSzdZt2tqYsOA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v3 0/4] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP
Date: Sat, 21 Nov 2026 08:54:05 +0800
X-OQ-MSGID: <20261121005409.17626-1-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series makes HDR work on pre-ICL eDP panels that decode the metadata
through the Intel AUX HDR interface instead of a gamut metadata DIP.

Patch 1 removes the LSPCON check from intel_dp_has_gamut_metadata_dip(),
which made the helper answer the wrong question.

Patch 2 attaches HDR_OUTPUT_METADATA on eDP when the panel's TCON advertises
PQ decoding, and skips the infoframe when no DIP is available.

Patch 3 is the pre-existing LSPCON issue pointed out during review: refuse
HDR support when the port cannot transmit the gamut metadata DIP.

Patch 4 writes the content luminance over DPCD only when the SDP path is not
in use, since the SDP takes precedence.

v3:
 - Drop the LSPCON check from intel_dp_has_gamut_metadata_dip() and move it
   to intel_dp_add_properties(), per Ville.
 - Fold the checks into intel_dp_hdr_metadata_supported() instead of an
   ever growing if-statement.
 - Add the LSPCON DIP check as a separate patch, per Ville.
 - Invert the content luminance condition: use DPCD when there is no SDP.
 - Dropped the fastset concern from v2. The analysis was confirmed correct,
   but HDR metadata fastset support is already broken and needs a separate
   fix (possibly crtc_state->backlight_changed), so it does not belong here.

v2:
 - Do not skip the infoframe on LSPCON (superseded by patch 1 and 2).
 - Only attach the property when the Intel AUX HDR backlight interface is in
   use, to avoid reading the untagged union.

Testing: CometLake-U (Gen9.5) laptop with a 3840x2160 10bpc eDP panel that
advertises BT2020 + ST2084. With the equivalent change applied the connector
exposes HDR_OUTPUT_METADATA, GNOME 50 offers the HDR switch, and the panel
enters PQ/BT2020 mode. The TCON HDR backlight interface was already in use.
v3 was compile-tested only; I have not re-run the runtime test.

Yitian Shao (4):
  drm/i915/dp: Drop LSPCON check from intel_dp_has_gamut_metadata_dip()
  drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP with TCON HDR support
  drm/i915/display: Check gamut metadata DIP support in LSPCON HDR
    detection
  drm/i915/dp: Prefer SDP over DPCD for HDR content luminance

 drivers/gpu/drm/i915/display/intel_dp.c       | 32 ++++++++++++++++---
 .../drm/i915/display/intel_dp_aux_backlight.c | 11 ++++++-
 .../drm/i915/display/intel_dp_aux_backlight.h |  3 ++
 drivers/gpu/drm/i915/display/intel_lspcon.c   |  5 +++
 4 files changed, 46 insertions(+), 5 deletions(-)

-- 
2.53.0


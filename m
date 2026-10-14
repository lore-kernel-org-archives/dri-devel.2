Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC427CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE65112193;
	Thu, 15 Oct 2026 07:57:19 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA6B10E9C1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:25:31 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5db19e2ef99so223367e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791991530; x=1792596330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ByuDN4/B1x5JlHCJPQ+ueE1qolHJj9yRQEgaRjuCRjU=;
 b=KuoyUyDqusk96FaKOHHwGZzt4fPAuh6WpvCC2d7gbd7Cdr2jdhIaClzMhiVzsHtzW8
 ryJk1mjMqbKF7/Bjsw5RJabPWRw9rsZ+pNCgYkjSkO43OLg4sBv5F5DRzud6v+aS3VWV
 5Ep1hIZJDlhGBEWqaDVIykDqKUn1K6tsneGcrkuUmhmU/xym+39VnVf8uZov9BtghOXc
 elB0HwBeqfzIgII/H5Xjhj4HiX7RwzQu0ERiz8LdU8iYw7MwhejYWXICqUOG0Adv6Wpq
 bKy5bu08HxMna/0OfxKgmQlUEx7zcGjo5D+ZnUpw41zdThDKIshQka9IL7h4BLC8wCJX
 M18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791991530; x=1792596330;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ByuDN4/B1x5JlHCJPQ+ueE1qolHJj9yRQEgaRjuCRjU=;
 b=Hz4Wn20by/7eUVWDvd+dHdioW6yuKf+dEgxyz5r5C3pftB3ED/S1btQ52HYtSJ8GBG
 3Ln2gi/plpbQGMmnEtTvL1yK3Pwj6Fu8CD3/s7ts4xWawIMNk8NtSLJARRpe8hVAAnec
 wQxDD9KWHbnSPh1GhzS+eDBrtrJO9WCUD4H9vw7nRwzJGvcbFZooJDcBT9mkTVnj+l2V
 zLtW+M6hgwTm3JWxzS67E7PlY1JhJTY928oxzvUSvE2MvArNX1PGhhppWKcZVVkYk9ST
 F2nvUQ5N3238L9Xr38IW0BhTFZK8wGsrb+i+v1dr3UcJN+aiwWmzgQyoRGaJKmmfm5zs
 iCIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrAIfNJukCI5BKjK1BfYTeiYJ6AWHXMwKpkIQousnErTNATwVB1fKVoHmFfZczXDo/SCTq4K90ASA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKXhXcquDmh1KW5EJpqjp7JtnWgBYwlDC8nrS8rzA/IwLv36ck
 37gHgp2e3Pn8zDh/wkH0ax+fshsu9qk0b0tH4+b+CB4gjqun0wwPMgF9
X-Gm-Gg: AYBFou2yjew4p9ZdqXkvX+XFIIVFoGQh7+X+7s7dzl+CIZX9x+HU3wuJAr2N4LTKa2p
 QymgN+kkhySWEBVSvriJgAoRKVsANSEUrklEkUoqfkFqIDQ88g4uJdQ7qdVeOXsx8cnqpZo2GhE
 SYY0iiwnXiXmKwNcnjq2BoGk0ZGSElXcZDtxfLb+G94Tgd2RRL03emb59tKMOMeQFRuwZCQUkcN
 bjO1YiAGGJVDk0oLOl+EDVynaOZDqTPRkecH8NGO5yqLWKnJs0JjNIKqQtpDeQswMgUxw8c8nZP
 tzpQG5+/e5T9zlRB8jAd+yGpX1fpJBlKzilunn4mX6lMbdW6ppnMyXsmrL6lfUZv5dOj5ON/uYu
 /U0bVJAimnjApOxlfxPi6blWixI6VPwD06GOkxiR8P+2VRej9X0CXBFE82kKfLeMzjYhTzUfhMU
 FnzbD2idBpyYWp8Gzl4eQk9kDrC+KYcJMD/JU/AlhqmVFSfBFgyg8/5G7hd4zMod/IrvzM88CMp
 5k0VUPc944MyCABWsmA+hyYGZN1lvZOcadjVy5bH7ZNLenGZ5sNKpvZFq0ldZxYdRyZhQS0POXD
 1qPeOA77QGhSPVN6k8Gd13P3iEU7g9t48OXJER1lzuSRRe/X
X-Received: by 2002:a05:6122:3b10:b0:5e9:484a:3499 with SMTP id
 71dfb90a1353d-5e9484a38e0mr2792831e0c.2.1791991529768; 
 Wed, 14 Oct 2026 08:25:29 -0700 (PDT)
Received: from debian-t14-gen1-fuhrysteve.ts.fuhry.app
 (235.sub-75-230-129.myvzw.com. [75.230.129.235])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97c39482sm54744986d6.45.2026.10.14.08.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:25:29 -0700 (PDT)
From: "Stephen J. Fuhry" <fuhrysteve@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Animesh Manna <animesh.manna@intel.com>,
 "Stephen J. Fuhry" <fuhrysteve@gmail.com>
Subject: [PATCH v2] drm/i915/display: guard intel_alpm_get_error() against
 non-ALPM sinks
Date: Wed, 14 Oct 2026 11:25:26 -0400
Message-ID: <20261014152526.2523534-1-fuhrysteve@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

intel_alpm_get_error() unconditionally reads DP_RECEIVER_ALPM_STATUS via
AUX from any DP connection that receives a short-pulse interrupt.
However, alpm_dpcd is only populated by intel_edp_init_dpcd(), so it is
zero for all external (non-eDP) DP and DP-MST connections. On such
connections the AUX read fails, producing a spurious

  [drm] *ERROR* Error reading ALPM status

and setting sink_alpm_error = true, even on hardware that never enabled
ALPM.

intel_alpm_disable() already returns early on !intel_dp->alpm_dpcd;
apply the same check in intel_alpm_get_error() so it skips the AUX
transaction when the sink does not support ALPM.

Seen on a ThinkPad T14 Gen 3 (Alder Lake-P) docked through a Lenovo
ThinkPad USB-C Dock Gen2 with two DP-MST monitors: the error fired once
on the dock's upstream DP port on every DPMS wake.

Fixes: 2063174c22da ("drm/i915/lobf: Check for sink error and disable LOBF")
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Stephen J. Fuhry <fuhrysteve@gmail.com>
---
v2:
- Rebased onto drm-tip. intel_alpm_get_error() now uses
  drm_dp_dpcd_read_byte(), so v1 no longer applied; the change itself
  is the same three lines.
- Carried Jouni's Reviewed-by from v1, since the logic is unchanged.
- Corrected the hardware in the commit message: the machine is a T14
  Gen 3 (Alder Lake-P), not a Gen 1.
- The error was observed with a ThinkPad USB-C Dock Gen2 and has not been
  retested since the move to a Thunderbolt 4 dock.

v1: https://lore.kernel.org/intel-gfx/20260611125408.676626-1-fuhrysteve@gmail.com/

 drivers/gpu/drm/i915/display/intel_alpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index f54b29e..059287d 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -754,6 +754,9 @@ bool intel_alpm_get_error(struct intel_dp *intel_dp)
 	int ret;
 	u8 val;
 
+	if (!intel_dp->alpm_dpcd)
+		return false;
+
 	ret = drm_dp_dpcd_read_byte(aux, DP_RECEIVER_ALPM_STATUS, &val);
 	if (ret < 0) {
 		drm_err(display->drm, "Error reading ALPM status (%pe)\n", ERR_PTR(ret));
-- 
2.47.3


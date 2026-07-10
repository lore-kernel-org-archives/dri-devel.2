Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96745C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9502710E7A3;
	Mon, 13 Jul 2026 07:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nlIyWkA6";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C4B10E18B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:52:38 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-726840fb461so200944137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 03:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783680757; cv=none;
 d=google.com; s=arc-20260327;
 b=EbOLvNaTLy8y1++/qdfhepKm2yILy5M2EoAeGQlhIZRe0k/JetgpS07ltkXIQy0uhV
 iWu9u06Owq9flYfw/cDg8H0H8YRxAV1TiyQ+CQKqArfFBxOMfo5b4Iy4p0xOemeFHvHI
 VdUYs+o1ePcehCApeAOpULoG917OHkrtIwDxczlC0cwBreDzpKQ4hcZuho7MyJ+oR20P
 p6kCME+FusEWAzGjFsQiYLD/miIf1BH7wk5JKnUQQuHe7z4kaSzApS13tPtu0JQ7W3Ea
 tQO72ZFLVZM1Ylr7OrtP8u37y/sgMgFpmLhbVmiCM2F5W3isGvpsvlbjqpGmwQ6tZtyO
 uB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=tE2af13ZjzzmnvVf9fs+rE4jiyGOe38dSKqZUzwPabM=;
 fh=w6JqfIVEzaghpsoiSjsa0bnHLg1D/ntegzuXmR8hkyM=;
 b=TrWwinI9fRJ8yn4PlRscgHH71lQk7pfzfmHJVFSX+r0TClH8omTn9tIDc9AHusTI3S
 sVhcLXXRQQLgCRft0O1NswK9dYZ6qmuUDtHeqluOigVAcT7eAzSig/CNDY1klmFY+WeY
 DWdDThvMl1UxshqV2pMt2MaOBtxk5AE0/kYz65Vi8NlNluBckKTWIy03AcKqf9qoFzbb
 IuB2aya7z+a5vXAakelgqiywGZDX9A9nXq6xZYCz3PWbUf/AXzzWnCK9632uhgpZ+uQv
 bb6dj8a/ea61FdGSHrQ67oT0RTgF/EVtJi3AZmgSkbTe4ua6djJ2zrLRZCsZP7tlYhsq
 39PQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783680757; x=1784285557; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tE2af13ZjzzmnvVf9fs+rE4jiyGOe38dSKqZUzwPabM=;
 b=nlIyWkA6Aq4/V0CiWstBCk/dNWOwWOuwhG0MkN1qfQf3jnkL222sSkcEVP+nAUJP7o
 xnxVXp4mmTZbI1NqoL9ovCyqyNXEiNB8ghS0xpL5jsQhzexRThwdYd73Qh7dBL7AGUbn
 ftem6jkiT9QgU59qqvFPvzj2I3tUpzMTmt3aftqWFaMs3KiaaIfi6LFPZIAFezoCqNWr
 qtHj21NuMpNRxxVukP0bHjBeJo1lH8A+gcTF09ljIiZz78VJws9n3ZAtoMmJ4RKMBidX
 1ngzYINtIBG2QJ506DTJveREyylSm4UUUc2LvZD7W9r2ZY+cwgI/S5edsS+vhlNYBN0z
 Id1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783680757; x=1784285557;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tE2af13ZjzzmnvVf9fs+rE4jiyGOe38dSKqZUzwPabM=;
 b=P8Q5UR25fX1Vz09PudCU5b2TDN3UgfONVOT+/J1Oa5HOq8aOXAoZMoTHYHtWWwXWZg
 Plkh9cHG2U1Q9Ddsfws+NAaPwqRfytVDJqYxSCM7hoo7h+m524QNVRmUQVk8rvBjl4HM
 iD8tAoauNbvTqzff5iH0ZzUJM/I3Bi59WvbIRRgK3WP/1PZK4X8aM/updgQ8a9ntf9lI
 JUnBNX2XOjHbg9CKxLGBRr7yXhCbqeBB6+ufqqPa+rpAXMOkXxQKe9CL2aqNLECkZCqQ
 tCjRckOIgFSxMo7y9bHY740Sy6/ebVH08LyjGqtplkfcITA7jrL883N2BGOMY/xM62WG
 nTdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBUHqg1WhlP/AB7reuSIwuwZwXOr8q3Sh9kwpfiuPZixdgu9f97dYLlnL3JFvEU8oL0DO/OFGSGck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS3lhxhtFAI6NIUADA6Bkjd1Gl8AxH+7C05jo2epmwc32sraFn
 2Z1KyEF0z8Gwq8LImSK+NedFpLlpWTETLSNLfQoSXhS5ZISi3p+K6xXxL1tNTY+9QF+EqsUZlL5
 0SCqBPbT2McXeGP9MNHCfp0wJCmWyfKo=
X-Gm-Gg: AfdE7ck7Ycnl7EwJB5XFewe0rglA2ZGpHrmtCz1JgyKZDIjTpvcQM6teQaz+w8g/Evz
 jKkIy88ckqSaYTJP61AG1+pdaQzGfEFTBmFZp0WwzmprY97iTiSsG+odu5ZnqvSh136mFt0iYra
 +kOEmAlpqqN/xqJXWa1n0mRKc8RgCiXG218w78up5zUyTrcpAKxmX/GJ58tGG2Awp2IKh8d18Yu
 8CAZte2qjxRLwSRuG/j8qp5V6x24j7fjOyjz1FFyGTbb99UNz394SPse7UpTvJjaF6HnhkFTQ==
X-Received: by 2002:a05:6102:598c:b0:744:a17f:7ba2 with SMTP id
 ada2fe7eead31-744e03134f3mr6196938137.16.1783680757324; Fri, 10 Jul 2026
 03:52:37 -0700 (PDT)
MIME-Version: 1.0
From: Andriy Korud <a.korud@gmail.com>
Date: Fri, 10 Jul 2026 12:52:26 +0200
X-Gm-Features: AUfX_mwv-W63-i1yM_kVKRADc5pL3y_XCJPzArDNGAtBVvnwYfFmilX7njJhzjg
Message-ID: <CAOidqQDq6khYfEjSz8=FHNBnR_nd17WYZDn7OdWOPG4BgPtTwQ@mail.gmail.com>
Subject: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream encoders
 for DP MST
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mario.limonciello@amd.com, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

From d37cbde6a3b3e57a5dc794514e77fc66e7fa8943 Mon Sep 17 00:00:00 2001
From: Andriy Korud <a.korud@gmail.com>
Date: Fri, 10 Jul 2026 12:36:59 +0200
Subject: [PATCH drm-amd] drm/amd/display: dce100: skip non-DP stream encoders
for DP MST

On DCE8-class ASICs (e.g. Bonaire), the resource pool contains digital
DIG stream encoders plus one analog DAC encoder. When assigning a stream
encoder for a second DisplayPort MST stream, if the preferred digital
encoder is already acquired, dce100_find_first_free_match_stream_enc_for_link()
falls back to the first free pool entry. That entry may be the analog
encoder, whose funcs table lacks DP hooks such as dp_set_stream_attribute.
The subsequent atomic commit then dereferences NULL function pointers in
link_set_dpms_on() and crashes.

Skip encoders without dp_set_stream_attribute when the stream uses a DP
signal (including MST). Use dc_is_dp_signal(stream->signal) for the MST
fallback path instead of checking only the link connector signal.

Tested on:
- GPU: AMD Radeon R7 260X (Bonaire / DCE8)
- Board: Supermicro C9X299-PG300
- Setup: DP MST daisy chain, hotplug second monitor or have it connected on boot
- Kernel: 7.1.3 (issue observed since 6.19)
- Result: kernel oops without patch; dual monitors stable with patch

Signed-off-by: Andriy Korud <a.korud@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5162
---
.../drm/amd/display/dc/resource/dce100/dce100_resource.c | 9 ++++++++-
1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index b92d4f378d60..beaf2e654672 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -29,6 +29,7 @@
#include "stream_encoder.h"

#include "resource.h"
+#include "signal_types.h"
#include "clk_mgr.h"
#include "include/irq_service_interface.h"
#include "dio/virtual/virtual_stream_encoder.h"
@@ -992,6 +993,12 @@ struct stream_encoder
*dce100_find_first_free_match_stream_enc_for_link(
       for (i = 0; i < pool->stream_enc_count; i++) {
               if (!res_ctx->is_stream_enc_acquired[i] &&
                               pool->stream_enc[i]) {
+                       /* DP/MST needs a digital encoder; skip
analog/no-DP encoders */
+                       if (dc_is_dp_signal(stream->signal) &&
+                           (!pool->stream_enc[i]->funcs ||
+
!pool->stream_enc[i]->funcs->dp_set_stream_attribute))
+                               continue;
+
                       /* Store first available for MST second display
                        * in daisy chain use case
                        */
@@ -1014,7 +1021,7 @@ struct stream_encoder
*dce100_find_first_free_match_stream_enc_for_link(
        * required for non DP connectors.
        */

-       if (j >= 0 && link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT)
+       if (j >= 0 && dc_is_dp_signal(stream->signal))
               return pool->stream_enc[j];

       return NULL;
--
2.55.0

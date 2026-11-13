Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FD606A8AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=C8fdtVxC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD6B10E6FB;
	Fri, 13 Nov 2026 21:11:46 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F6F1127CB;
 Fri, 13 Nov 2026 21:11:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jR9154rJSzMlfM;
 Fri, 13 Nov 2026 22:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1794604297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=805vWcU4s6eOEpd5cH6cfQExyrCaLJl8qkBZOQ/FylY=;
 b=C8fdtVxCOdjrK4+sEfWY1pKjEhf/OEg8aYlUR6L1VkxbDEJibiZQkf26eSchpT2lbCDyZz
 0r3sPsDXtyoKn13uZkC7uh3ljQ0nCZD6oh8FfFCPcWjKfkiZou/Tia1W2630Rf0AFb0BQc
 p0pYv6vymP2YNhqyTeuYRNNukBxnA5BnVcbayQo2Pf977pZZ4Rt0XSwEZRkSLhp2H1Fnty
 9AFCtSLJWlhXWLm6U/GtTe4IPTYQ+Xy6UVqkhwDSspwdfTrlfccxI5hpeqmBWhDm5NkAf0
 yBxL6qit26QarX1zgvJr0o2jdhVhDYvaluOkjdaKffZv/ccdvlaVu21TJNQlYg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Fri, 13 Nov 2026 21:11:36 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: Ray Wu <ray.wu@amd.com>, alexander.deucher@amd.com, sunpeng.li@amd.com,
 harry.wentland@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org
Cc: simona@ffwll.ch, alex.hung@amd.com, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, lohita.mudimela@amd.com,
 bhawanpreet.lakha@amd.com, dri-devel@lists.freedesktop.org,
 roman.li@amd.com, airlied@gmail.com, christian.koenig@amd.com
Message-ID: <1406290810.470231.1794604296696@app.mailbox.org>
In-Reply-To: <7099a8ba-6508-4771-a97f-c681d0a8ceae@amd.com>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
 <7099a8ba-6508-4771-a97f-c681d0a8ceae@amd.com>
Subject: Re: [PATCH RFC RFT 0/8] drm/amd/display: Stop rounding backlight
 levels to whole percents
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jR9154rJSzMlfM
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 9:22 AM WET Ray Wu <ray.wu@amd.com> wrote:
> Patches 2/8 and 3/8 (LUT interpolation in the power module) are still
> useful on top of it, and I have already given my Reviewed-by on those.
>
> Could you test it on your machine?

Hi Ray,

Thanks, and sorry for the delay. I tested your four patches with 2/8 and
3/8 on top, on an ASUS ROG Flow X13 GV301QH, a Cezanne laptop with a PWM
backlight. I have no AUX panel, so this only covers the PWM path

With ABM off, I wrote these levels to brightness and read
actual_brightness back:

   level   actual   PWM
       1        1   0x0004
     500      500   0x055d
    1000     1000   0x0ab9
    2000     1999   0x0f1c
   32768    32769   0x6263
   65534    65534   0xfffd

From 0 to 3000 in steps of 50, the 61 levels got 61 different PWM
values. Across the whole range, in steps of 1024, the PWM never went
down. With your patches alone, 1 to 655 read back as 0, 1000 as 655 and
65534 as 64880

v1's 4/8 still matters for released kernels. Since commit 3c108046e1d6
("drm/amd/display: Add power module on Linux") in 7.2, amdgpu_dm hands
the power module whole percents, so PWM panels get at most 101 levels.
Before it, amdgpu_dm passed a 16-bit PWM value straight to
dc_link_set_backlight_level(). Your series alone still rounds to whole
percents too, in the power module's LUT, so the rounding needs fixing
either way. 

Which would you prefer:

- I send a v2 now that fixes it on the current tree: 4/8 with a Fixes
  tag, plus 2/8, 3/8 and their tests, on top of "drm/amd/display: Fix
  the doubled AUX backlight minimum on the custom curve" [1]. Your
  series then replaces the amdgpu_dm part
- I wait for your series and fix it on top of that. Your series already
  removes the rounding in amdgpu_dm, so that only needs 2/8 and 3/8

Thanks,
Hugo

[1] https://lore.kernel.org/r/20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es

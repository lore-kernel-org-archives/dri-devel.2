Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE11606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=Z09T2qsg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D701510E741;
	Tue,  3 Nov 2026 00:30:14 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AE210E741;
 Tue,  3 Nov 2026 00:30:08 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jJTx85RhZzMlSl;
 Tue, 03 Nov 2026 01:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793665804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJ8awdZJyu03pjP9iovo5hQpWlX7slf0qi7xPXVtajA=;
 b=Z09T2qsg5HfQxmjIDZeJjVC28sQdKrhhW4Skzi4s6YnEtEzCVZtROZ/EIE/Ypr/t/jT/cT
 Nph0AAy/qA5gZB5X2W8ZWpEtC/jYuMxHfsLBXbo7k0ARNkD3rCkF7r9zhzKf97l1lTsKK1
 4kFhBHp2NDdV+yslwWNr2qopdC1Y0u8VOzsSTcu6AR7W8Ryx20b2afRY1YtWnkthqVl0pA
 T2FE688Aj9UBsug6J/79IRifSaS6KzmT69jAjrC/YN0GFt3cA1P57mLreldylLuET+G/Sg
 BbglwcU8HcW0Y4Q/MTNSc11eaOQkKX+n4kI1K2BBPjeHm9Cg5O83GqWEaiIdFw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Tue, 3 Nov 2026 00:30:03 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: Mario Limonciello <superm1@kernel.org>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, alexander.deucher@amd.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <461302854.306462.1793665803972@app.mailbox.org>
In-Reply-To: <7b87b864-7896-4260-aad6-a78687201c0f@kernel.org>
References: <20261031134551.2735792-1-hugo@hsal.es>
 <7b87b864-7896-4260-aad6-a78687201c0f@kernel.org>
Subject: Re: [PATCH] drm: panel-backlight-quirks: Add ASUS ROG Flow X13
 3840x2400 panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jJTx85RhZzMlSl
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

On 11/2/26 23:13, Mario Limonciello wrote:
> Was this from looking at a datasheet or from empirical measurements?
> The reason it was safe to do on the Framework panel was because there
> was a confirmation the datasheet allowed a lower value.
>
> We don't want to be damaging hardware running it outside of spec.

Oh, damn, I didn't consider it could be damaging the panel and that it
could be out of spec. I did try looking for a datasheet for the
LQ134R1JW51 before sending this, but couldn't find one, and since it
"worked" (the panel stays lit at requested brightness 0, which reads
back as PWM 0 in amdgpu_current_backlight_pwm), I thought it was ok...

I've asked two people at ASUS whether the panel spec allows a lower
duty cycle, and I'll report back here. If you know someone who could
be of help, I'd appreciate the suggestion

One thing I noticed: 12 is also AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, and
it's what this machine's ATIF returned, as did the Framework's, for
completely different panels. So the 12 ASUS returns for this Sharp
panel looks like the AMD reference value passed through, not a number
ASUS took from Sharp's datasheet. Do you or anyone else here know if
that could be the case?

Another data point is the VBT dumped from the BIOS of the ROG Flow Z13
2022 (GZ301ZE BIOS 321), which ships the LQ134R1JW52 (vs my
LQ134R1JW51). It sets brightness_min_level to 0 and the older
min_brightness field to 6, so i915 already lets that machine go down
to PWM 0. This doesn't really settle anything for the JW51, though

Assume the patch can be discarded unless I get a reply from ASUS, in
which case I'll reply here again

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DE606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G7UA9p58
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC2C10F9C0;
	Wed, 28 Oct 2026 05:46:27 +0000 (UTC)
Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFBF10F9C0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 05:46:19 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=ijJh+MX1d9Q9tuIFC+EcG9ysQ6DSEveIjy0ac0Xxn1c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793166378; v=1; x=1793771178;
 b=G7UA9p58EY8JpjRyA8/YMP0tkNiQR8FRdrbEqTKxfMA/pzGEr4EyIVLfEl7aNgACPcCLLrnK
 Oq+XWuOn/GrlPtdaCRnjsH880R0Xva1Tq1lCMFixMjdyPaimFL0cqtmGuncVsF919dpmLIqYYak
 yYS0lRmw41/CQT3WvMy8asyU=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 1c1a32c249eada84;
 Wed, 28 Oct 2026 05:46:18 +0000
X-Mizu-Trace-ID: 1c1a32c249eada84
X-Migadu-Flow: FLOW_OUT
Message-ID: <7521fb7a-d46e-4e2a-89a8-ddd1b55e0afb@linux.dev>
Date: Tue, 27 Oct 2026 22:46:13 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: chipwealth-ch13726a: Fix dark grays rendering
 green at 120 Hz
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Teguh Sobirin
 <teguh@sobir.in>, Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261028020147.2014466-1-matthew.schwartz@linux.dev>
 <CALHNRZ9f8ZTnc0LnAJ+YPRYKA9D1=tvY=Ce6bf=91O=WWU6XmA@mail.gmail.com>
Content-Language: en-US
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <CALHNRZ9f8ZTnc0LnAJ+YPRYKA9D1=tvY=Ce6bf=91O=WWU6XmA@mail.gmail.com>
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 9:57 PM, Aaron Kling wrote:
> On Tue, Oct 27, 2026 at 9:02 PM Matthew Schwartz
> <matthew.schwartz@linux.dev> wrote:
>>
>> The init sequence writes 0xf0 0x50 followed by 0xb9 0x00. The panel
>> configuration in the Thor's stock Android firmware (decompiled from its
>> devicetree overlay, dtbo.img) has two runtime command sequences that
>> differ only in the 0xb9 value, both "display off; f0 50; b9 xx; display
>> on":
>>
>>   qcom,mdss-dsi-ram-command:        b9 11
>>   qcom,mdss-dsi-bypass-ram-command: b9 00
>>
>> With 0x00, in the 120 Hz mode, a full-screen gray ramp from black to
>> white, shown with identity color management, renders black as green and
>> the darkest grays as bright green, both at maximum and at reduced
>> brightness, and the tint is more noticeable at lower brightness. The
>> 60 Hz mode renders it correctly. With 0x11 the ramp renders correctly in
>> both modes and the panel dims without a color shift.
>>
>> Use 0x11, the value from the vendor's ram-command sequence, instead.
>>
>> Fixes: 3ee01b8647b5 ("drm/panel: Add panel driver for ChipWealth CH13726A based panels")
>> Reported-by: Aaron Kling <webgeek1234@gmail.com>
>> Link: https://lore.kernel.org/all/20260727-ch13726a-washout-v1-1-bf869ddfc5cf@gmail.com/
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>> Aaron, this should be the 120 Hz issue from your washout patch; could
>> you give it a try on your Thor? I found the issue here separately and
>> saw your patch as I was prepping for submission, and I bet I was seeing
>> the same bug you originally saw.
> 
> This is something we tried before. And best we can tell, enabling gram
> limits frame rate to 60hz on this panel. Framerate tests such as the
> ufo test were reporting 60 when set up like this. Can you verify the
> refresh rate on your device?

Hmm, yeah, it was a bit hard to tell until instrumenting it but it
seems to use a panel refresh rate of ~63 Hz. I do wonder if this panel
is just not meant to be driven at 120 Hz though, since it seems like a
very poor choice to expose as a mode with color issues like this.

It might make more sense to just not expose it if it isn't fixable.

- Matt

> 
> Aaron
> 
>>  drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
>> index 562dc573528d..0832e49b77a9 100644
>> --- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
>> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
>> @@ -65,7 +65,8 @@ static int ch13726a_on(struct ch13726a_panel *ctx)
>>         ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>>
>>         mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x50);
>> -       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x00);
>> +       /* 0x00 (the vendor "bypass ram" sequence) renders near-black as green */
>> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x11);
>>
>>         mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>>
>>
>> base-commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c
>> --
>> 2.56.0
>>


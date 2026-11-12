Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAEE606A33B
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SWfGlL5S;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Sa/bc71A;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SWfGlL5S;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Sa/bc71A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C163110E523;
	Thu, 12 Nov 2026 07:36:12 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959CA10E523
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:36:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BC5421E2E;
 Thu, 12 Nov 2026 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794468960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eLrr8pKqqR7ShkRhC77eJ4XB0RZSE5KVokQnCulB2o4=;
 b=SWfGlL5SP9QxUigmvUkfyufsOScTBkV0SKYv4XyB00QDFc56vIRgnLoooVn4Kfz5I6sU8G
 2TK/UiWAb60R81XNi8V6KibQBmpzUHvjBvSdB5YOMNrZCh/UDV61tfqznjFnZFjuE5zMid
 PhpBGV6jwyk26HJYE9lmUNvnG+oeKj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794468960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eLrr8pKqqR7ShkRhC77eJ4XB0RZSE5KVokQnCulB2o4=;
 b=Sa/bc71AVe/647ejfmkcDQX8ZQ9mMjzepp6L1XlFCiZXlLt06zcX3shwy7VBKqckpNTto4
 sg0Ykd6hzc53DsAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794468960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eLrr8pKqqR7ShkRhC77eJ4XB0RZSE5KVokQnCulB2o4=;
 b=SWfGlL5SP9QxUigmvUkfyufsOScTBkV0SKYv4XyB00QDFc56vIRgnLoooVn4Kfz5I6sU8G
 2TK/UiWAb60R81XNi8V6KibQBmpzUHvjBvSdB5YOMNrZCh/UDV61tfqznjFnZFjuE5zMid
 PhpBGV6jwyk26HJYE9lmUNvnG+oeKj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794468960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eLrr8pKqqR7ShkRhC77eJ4XB0RZSE5KVokQnCulB2o4=;
 b=Sa/bc71AVe/647ejfmkcDQX8ZQ9mMjzepp6L1XlFCiZXlLt06zcX3shwy7VBKqckpNTto4
 sg0Ykd6hzc53DsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC663134A0;
 Thu, 12 Nov 2026 07:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WBbQIF9s9WrAEAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 12 Nov 2026 07:35:59 +0000
Message-ID: <8a697d14-18c3-454c-979b-7042f16c66ba@suse.de>
Date: Thu, 12 Nov 2026 08:35:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: display: simple-framebuffer: Document
 mono format
To: Sebastian Raase <linux@sraa.de>
Cc: Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <cover.1793758480.git.linux@sraa.de>
 <258a1228601ab9b5dbb8f077dacf61121b641f15.1793758480.git.linux@sraa.de>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <258a1228601ab9b5dbb8f077dacf61121b641f15.1793758480.git.linux@sraa.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[dt];
 RCPT_COUNT_TWELVE(0.00)[14]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org,gmx.de];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 sraa.de:email]
X-Spam-Score: -11.79
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 04.11.26 um 03:34 schrieb Sebastian Raase:
> This is a 1 bit-per-pixel monochrome format, with 8 pixels/byte.
>
> Signed-off-by: Sebastian Raase <linux@sraa.de>
> ---
>   .../devicetree/bindings/display/simple-framebuffer.yaml         | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> index 45ffdebc9d86..c627ec088434 100644
> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> @@ -94,6 +94,7 @@ properties:
>     format:
>       description: >
>         Format of the framebuffer:
> +        * `mono` - 1-bit packed pixels, 8 pixels/byte

I don't object the change, but I really object the naming.

Mono is not a good name because it doesn't describe the format's pixel 
layout. For example, RGB with only 2 colors is also mono in some sense.

The common names used in the Linux kernel for this type of color format 
are C1 and R1. More generally speaking,

  - Cn describes an n-bit format with a palette. The pixel bits index 
into the palette.  Pixels are packed.
  - Rn describes an n-bit format with a single color channel. The 
channel has linear color gradient. Pixels are packed.

In your case, you'd define 'r1'. While at it, we can also define r2, r4, 
and r8.  The terminal supports up to 16 colors, so implementing r4 might 
be of interest to some simple hardware.

Best regards
Thomas


>           * `a1r5g5b5` - 16-bit pixels, d[15]=a, d[14:10]=r, d[9:5]=g, d[4:0]=b
>           * `a2r10g10b10` - 32-bit pixels, d[31:30]=a, d[29:20]=r, d[19:10]=g, d[9:0]=b
>           * `a8b8g8r8` - 32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r
> @@ -106,6 +107,7 @@ properties:
>           * `x8r8g8b8` - 32-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
>           * `x8b8g8r8` - 32-bit pixels, d[23:16]=b, d[15:8]=g, d[7:0]=r
>       enum:
> +      - mono
>         - a1r5g5b5
>         - a2r10g10b10
>         - a8b8g8r8

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)



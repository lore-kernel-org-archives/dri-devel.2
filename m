Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=plnMmrEu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC8510ECDA;
	Mon, 26 Oct 2026 08:51:57 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290BD10ECEB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:51:51 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so17144855e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793004709; x=1793609509; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xWiTlDTyc6PTyNRCBNyeHOu3tzSbgoo2LUTk5932AiQ=;
 b=plnMmrEuq7wyQLhwCDaiC2OcFlA/lSa0NqJHpdZjVro+gdqHXUAHlTDHExEyxryg/J
 b9/vLUjBy0dTqwiSjllC2UyPU439mXzZlBWQtdtVHhyvrhYWVfvA9AXHSDb2s8Tx6No7
 mS6rQoHWxLiWgqHbq2oBA6rgaWXmxhVV2zc2WrLD/P81cP3gIBbvpfb7jhnNUgt5CG32
 mPqQ0D4vU0/CTa8XSX+XKwe72G9MKHTfS6Tr0h8MgVm6tMF579Qhbndabsob7AOhYLBW
 s5ZkCU0CSgeCucsKco5V4SrlrtMTH1EthYvIun+/9plS2B1ic5tDbliICfYrPEX9S7BY
 oPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004709; x=1793609509;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xWiTlDTyc6PTyNRCBNyeHOu3tzSbgoo2LUTk5932AiQ=;
 b=ugV0kulUvUgiFzqjq7UKeN4T6lwH+FNrfjP7TkkhWP6Ihnir4KT3eLsxSViwQhH2Ui
 lgxyxr98zZMM6DukziWM347WfCad6Hb/0qkpeD5LZx9hzM8qN/nxNWQE2wSLKYbWjitv
 xJPGU7k97FvooWhrAWjY8vUmbPBDYSCemdwoYU8u72KRJ+NncPpEIuELw8Ae10otZiky
 pD8fHKSjU6QHd3JEYTWNCRNWzRyWiAX4CnVEPir52y5MNKkYauAxVNUat5vM7EN+H30N
 DS9j7EC9UIbL1lWVG1bLzrpDr1GilnNb7+AKqXa3Fts6pnrcYW7ozta/JNf4b3V6PQE9
 Za4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDEjljhu7G/vRf38F71uQ9lYhrf+haLMMmoCJepXvvdAq9/Ld4pYxJ0HXVW4TE1KkvcxgKa2wYmOs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLYWim5wGUzGViHJbw0xbRRbVdO2gV6lIq7GaPV/Bx41lWD7QiX
 Dimc1WhlcQV9q5negJUBrAVwgfmFdRKpHE8FgOAiwE50VjY1lEhicL/K
X-Gm-Gg: AYBFou15YpqYswLV/fCCttW/4WkD85wEg5zRR3nlEN6zvKU5jF2YFW3ZEpSHxXbnNj9
 EUDKmayow+yshRAlGwvLMG7jvnyw0jo+FfKF1FtITYNAq7ULZDbVq4bsHAksm4A7G32phZUZ9zN
 j9e7U0RB89LcsIkZ5eeddSIZxkXlb0+owUOfayi8m7M5WzTlBfFLz7A930CUwM3GQyg6VAVH/9Y
 f2K69+YO9i56s8rAsPbTC4ec4w0mYsWUcjfE4YG5jdx3/7Ev93ogceQ7DOC15gA8raY3j4sRhfa
 HdSGH9vbiXQA+T+AzYALNWcMLLzTtwf/BoSDAog4M4cMrEzwUzG6U/0SAtk7lPW6cFhxjgWCF0j
 FXuwQe9P+gZ2lLUAj7l1A1bWk8xefjnSHh/YaL5+UOMjO10mv0YWpopYydrRqRcZCcTmzY4GBll
 Wkm1LtypkTdKeI0sfXMd+OkO47zbVEm3dsA/J6pFvRHu1tQZ+A3xi+t+lk/5H3Xoxman/mZVSr8
 ggW9nG6QFdVJHyTldkrWmKx/6mM1Z3pC9Tu5ufOhfess360zfv6
X-Received: by 2002:a05:600c:630f:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4a35ae9e071mr121463405e9.12.1793004709351; 
 Mon, 26 Oct 2026 01:51:49 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm224781085e9.4.2026.10.26.01.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 01:51:48 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:51:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
Message-ID: <at8UoLDzrO9ypMeR@stanley.mountain>
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 01:48:32PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> fbtft_init_dbg is not used in drivers/staging/fbtft directory and
> since dev_dbg messages are good enough, fbtft_init_dbg should be
> removed. After compiling the driver, there are no undefined macro
> issues.

This commit message is sort of acceptable but a better commit message
would be:

"The fbtft_init_dbg() macro is not used, so delete it."

1. () after the macro name to show it works as a function.
2. We care about the whole kernel not just drivers/staging/fbtft.
3. No need to discuss dev_dbg().  That is unrelated.
4. No need to discuss compiling the driver since that is assumed.

Otherwise it looks fine.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter



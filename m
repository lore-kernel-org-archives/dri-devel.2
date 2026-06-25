Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A317CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A84310F236;
	Thu, 25 Jun 2026 10:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qHmI4G0e";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9FD10F236
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:30:36 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c88b7c92577so846672a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 03:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782383436; cv=none;
 d=google.com; s=arc-20260327;
 b=dTIP73JpC3MCQgXA9E4teEJllzFUj7zQV+a9TdAjlFRPZOPgd3KtsbL3oXpQr+fy+W
 plXM2pi18xJqjXZ29fwOSAWnZ9+2XyymW/3xb1mjkgZ/xFUkRSsEVV6a/C3L6vtXJl2g
 ed0dlacRhvX7/ML+rIKF3Z3vX73khFrmhVsIhNAD61b0kzfxj3vlNCkGXiZWDlYremtq
 UWwWiEPU31fKpEUqMdt6UYPNQWIqaKNbvpHgQBeSk3yLcwMcX5hzbfZmbjMqS0BC3Xvp
 XFksZVBLOH8bqbtrgUhl6XNkba8HlvbaRQbbFZC9WF8gfvLdi7HrPxNMAAxo3aDvC1k+
 BMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AvoQHghqbYYBynr9L28jSbgEoJOOe82Wl0qq9VqZVeE=;
 fh=blO8t+QD4Vsvgbui79msuBsgefCQ57KT770voT4kIMI=;
 b=d0kuUl+TfLR9tlMqQGiNE2tF3N4Fi+mCZyi0bG6PLnoNykp2VDLSt9IRLYpufe4vxp
 qHY7algdx/Yt6GKlC4IwPtcOMqK5SyUPL+Y3E3BntY9EL4c8lASMBIvypxCOSJDTqTU/
 r3mudY/0N/S+QE8vplgrMFbrjxlj4ZoiQvo6ujs554CxYlH7JTGqEBIfSMhzEC+sEf+S
 ZBPeoiaJ/2gsdKdIyKYF8IHt+yFOmcn4UkH6iIn7uXVKf1hP3mStuVyo0945KNr3+Y9z
 tfVK/tVjzcNuR8PoD06jlosa25/gGuguutYWcTehMpzUjSfjp8sdS2/nZke9yd67Z0Qc
 TtQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782383436; x=1782988236; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AvoQHghqbYYBynr9L28jSbgEoJOOe82Wl0qq9VqZVeE=;
 b=qHmI4G0eOBvLJJRqbG0d/Nihp6b1wKApoadb/Ui/hW25aspP8stzb2R2VDtWkn5cqx
 ZI1xKqeJou9iHNIJjBANgUPJrza/tAbSO3uTlhy0qvM7gjK2qwXtH7p8jIwJr5JU8bWX
 O+/RkDUBOQMumTcdZ/k/ht5SCF7bGz9hxtPw4VcTZ3ZVy8g3tMj8tp0tugz8wEQdEdvv
 GRNWB7OQDT5YWynpknrd1B5DPG/oo8/o+FT9wpKqFO9sIkh6F+14Qur7ZR7VEc06i0VO
 IDxyYYYFgn9rqY835Gx15BTJWGZFIR8Gk89okWjo01LAEBz/8EZ9e94W5IJ0TDU/4vEZ
 x/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782383436; x=1782988236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvoQHghqbYYBynr9L28jSbgEoJOOe82Wl0qq9VqZVeE=;
 b=T9XMwN+z1Wd/AxmAKFKUGWUaQk1YSmveGn+qwM7GBPSvAsGNme7ve4Sw3gc41G/Eix
 a3KdcpORxM6XMiBtw/DRVQ7B4PpiA9YerYRvbdLgsPysA4HBMpUNLUdXv7cWQ7egRuK6
 p1pbdNJNBux0hfYrMJWEn7WJOyvNpSgYoZnBhCL5oQz6gjFPk13yGNSPOob8nCRs5c+j
 uBB+lxmj2a+zvSM1J7Tk4FDCEbJKimzzeqN7rH3i9Uw4xbyCKs/ns1NXP6i6XHn4/rN6
 ArWupNcN+2t60X6wd9YqKmQ9OWy6C/KxKh2XnvhhcnTTTCIWbsLSWh12xgyewtAM7O+g
 YKEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eOBMXY+ovef26GUq2fIlWa8W9kReD1Jlmkvi7kepB1uPKU8622Lo16q1DMg3rovXGofiIOlP7nA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAv+efHSn5oCxT4U9usMK+Dl3wWo4hOAFtMsf/4cEbMeVBoPAe
 lEnEamgqp089QMnZhOQZg1mHtZF4ZHXDSXG5KeHrFUvgsXtXENqh8TyY8kaQuza6Gs8vwG4r7rB
 kU4wzGlGlkooKx+Ocy0PmjxMa8qn/aJU=
X-Gm-Gg: AfdE7cnUfMcZCSEvSCuutfg3gCOH/cjeEe5khwA6aanjUwD/iYHbXkN1QEmDAvC8frw
 t39RAN9CZoHS4fj1LPzNFKwSEoe2Cur2p64BDIvo3o6WlRqRiNsTf6By34YxWGKIBwDzAIxdwaE
 Id7b6s0PKzZ4jSlM2H6gzzbrr4Hg3zfFSaPjURl9kWlIhEEz9NR7Y98M831G1ZBUC6whrq4vx0E
 PGcZRa6rpxub/lnsdjrEwqsSuDHKIaQJoxAU1zupmJekjI1AYYRzMHZxaDGT2k6CEG1PUjAB5U=
X-Received: by 2002:a05:6a20:914b:b0:3bd:187e:2d1 with SMTP id
 adf61e73a8af0-3bd4ae0f890mr2352631637.23.1782383435568; Thu, 25 Jun 2026
 03:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
 <aj0Cv0Wzb3rieNqW@stanley.mountain>
In-Reply-To: <aj0Cv0Wzb3rieNqW@stanley.mountain>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 25 Jun 2026 16:00:24 +0530
X-Gm-Features: AVVi8CcdIPL3-1B_-CzFZpXWUulit7-jlDYUNVs_z6-h4OjuWGoke0kaVKBdZ64
Message-ID: <CAB0uMAeMOV4Xhq2cNVjxne89yqF8vdubM8-OpPYGK4f4yBLMNw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace empty modifier argument with
 no-op macro
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Dan,

Thank you for the feedback. I understand and will drop this patch.

I have also noticed two pre-existing bugs in the same file
(unaligned access and buffer size calculation when startbyte is used)
and have sent a separate patch to fix those.

Regards,
suryasaimadhu

On Thu, 25 Jun 2026 at 15:58, Dan Carpenter <error27@gmail.com> wrote:
>
> On Thu, Jun 25, 2026 at 05:27:21PM +0800, suryasaimadhu wrote:
> > Define fbtft_write_reg_no_modifier() as an identity function and
> > use it in place of empty modifier arguments in define_fbtft_write_reg()
> > calls to fix checkpatch errors.
> >
> > Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> > ---
>
> I don't hate this patch, but I think we've decided to leave this
> as-is.
>
> regards,
> dan carpenter
>

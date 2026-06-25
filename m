Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD45CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8795F10F235;
	Thu, 25 Jun 2026 10:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ec4JaeAg";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A736E10F235
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:28:25 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-48662d16d08so815985b6e.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782383305; x=1782988105; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=otpXdjNkhvgaZ3XJWWSziZvKCi33swAVBBkTmAhDpkc=;
 b=ec4JaeAgOP0xuTqqHlg2CZ+1HAVk6GdgYHKs32xjPAJP06hH26wl10ykgS72SagwJf
 Bg6pgwr2pULhB8UMvYI8kMTmRqgKmgSzNDFpx3P2IYsUSUBI33y7VGSWQFo+TEl8J04E
 N4py5weaNlyRSU/NPDfAAe2ibQjUUEZRc6Q6LqPCy6lWjK8+KJb7N1+UTp4YFPImefKG
 aUaE8gCzdI3hhGEiM9jgupiRmq4aakNvYudeDS/g74sRIbY0A+sJirfURHn4hAFg3JOH
 syVw72p3VG6DXHTlHd7mM965At2MXko3OmFOYtRnFk+F9P8DuFkO3zGeL04fcyjLhF2V
 ExEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782383305; x=1782988105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otpXdjNkhvgaZ3XJWWSziZvKCi33swAVBBkTmAhDpkc=;
 b=fBg1tgd8vU7gMRwkzcLWHuW5A1IMUTB3VGltkDULQOBy0GQJy6MU4Mmq6vxtBvk1xm
 cMiFzx/pKR/sCqva3tv581HxAoYQF+3ybAoB0dp+JtddZwZEWqnnrxvbUFMyBEemKuVe
 PzsJtsLYlQxY+QuWLtboPsM7FlPk73yfXllNdUoCiIwbwHxthLQNGyyU7K46p0rsFvPn
 /4I1oLUJImvXYURINkb3tPPVfm5k3yDJEpECsgsOHhRuqQ2rGoh1FP8NySbOkTkE2yNo
 csMpBoo0pst4t9kg6Do1TASvQ2hPmxTNqnfku+U6Nff7XuhiU4kqcQOv8383BSxEkl8E
 mdXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZUwPOUuCfVltzYE4h/LChnxCWQXelhONOcv73w9G/uUMPbXBc6JKWHiH5DOVYcmyZ78ySJCra6xY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH1TVx2Y2VoYHbiCfXkZA7bLKKsm+8W2qzSVex/1vOBu/DOKNN
 zdECrMU34VcZQVhLFRXhAgRmrV+GzDd33PatipBnJxRrAdNuhR+QbNH8
X-Gm-Gg: AfdE7clLuMJCqlhWUz4apOkt8S+Yl49teu1iYW1Wf+yyIreI7bkr0LvL65wK9TvJbu7
 L1dmBG0rJAlKxCWjiBzlEdKNzERebGZxPAbzybJiYS1MFAEmOJaWM21kZEbyINbh0FqVSYTsT0s
 RbyQ9826m6dsRxtT7Bp2yaJzt7TGywIogL8XKIuTwZ9/eY4F1NU1CXpLuNInulXnPQ0HSTZTLTX
 ZvPQWR3a+LsjNIo4VvDfADQ5IzC5nP8HAOH8fYZiUav1hl/fMCoD7QYe3bS+Z1DXwOVHRNzx0L5
 h5XxeptnqbvUOIVm3Mpblk6rSvYiVncRBKNQt8cfOY0VmszRJlKjePAQInYCW1f4YxFfqSRExcY
 nmB46m8cyN2MNZB6FBb38Z4OWKEiMC4ZdH6QUCVEbLB7ZEeszGcb1M/W42TvoBya2iLxOh9xW6S
 OFrEUl
X-Received: by 2002:a05:6808:6718:b0:490:b586:1459 with SMTP id
 5614622812f47-4921573deccmr1924568b6e.2.1782383304720; 
 Thu, 25 Jun 2026 03:28:24 -0700 (PDT)
Received: from localhost ([74.80.182.98]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aebb9f1e4sm10496756b6e.1.2026.06.25.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 03:28:22 -0700 (PDT)
Date: Thu, 25 Jun 2026 13:28:15 +0300
From: Dan Carpenter <error27@gmail.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace empty modifier argument with
 no-op macro
Message-ID: <aj0Cv0Wzb3rieNqW@stanley.mountain>
References: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
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

On Thu, Jun 25, 2026 at 05:27:21PM +0800, suryasaimadhu wrote:
> Define fbtft_write_reg_no_modifier() as an identity function and
> use it in place of empty modifier arguments in define_fbtft_write_reg()
> calls to fix checkpatch errors.
> 
> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> ---

I don't hate this patch, but I think we've decided to leave this
as-is.

regards,
dan carpenter


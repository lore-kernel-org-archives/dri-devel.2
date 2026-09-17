Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C2C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CB110EE66;
	Thu, 17 Sep 2026 12:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DArW/Rkf";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A24D10EE89
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:29:41 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so3772715e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789648180; x=1790252980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dtz+Uqi8FvhezfQGwgUreP+CufNocr9p+NqbDN0Xcok=;
 b=DArW/Rkfi4vGu5Y/XtlnqmD6IKek5dHlU8DiOPV9WNQOEILhZ32W3gHnsBCOHoPhEj
 ofqIFXXlyiJkrbeJYDp5kjZ/M0PBJeclmmUTfQ4CYl+OPWuZm4MQ5yvq7uT5DrAkFIjb
 SrTMUroo5+6jPg6TmR6SX5Tv7RW3QsjwNhawIMvGfY0M3FLhztSXn8H0RFU8K45uX9Rp
 zQmnm0fr40N52rloYeRnRcXCyWDVqwRvy9cDre9MNM/a/JRFuxXpT7+VhezDj6c7BZ2W
 WX2um/1gdCDvkiM51yyng7Hg3IiaeLXOC15DS/36X+J9LoJkxqGt1hxODFefWbVVYfXC
 +9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648180; x=1790252980;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dtz+Uqi8FvhezfQGwgUreP+CufNocr9p+NqbDN0Xcok=;
 b=ucFtIOaoTwOkBzfgs6rTNndUEo/YDzCjDTdDPi69UeiNuBcZSE9UAXhzTvkZCN/vHj
 snYLzOE1S6Qg7GvnorxYRIRFiUccC6bPdv8HbU7xwzgTADSsNAZ9zVZqazUSYQniPWWv
 77k2N4lM2doS/Qzj5a4lhwtENu5mOSFzy/eVkCKR3y72Yl6ETACx1tf2Da+TNpvVx81y
 0lwVUQjQlqcg2teVNOnVwD6Am1I9+Umd6ZB0OWGSvTRWQmtVirK50x493yqwupF/NN80
 SqOlQ1KJ/VLyp77BSbRiCWgC3jK/K5sZWE51zpGPVgLZGpbj0m1V8ckcZ7qQa1auVWIZ
 dQLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwFdNyCat1mIy1LjNXr8k92JMi5X1rX6iGacg9yiolM0ghvdru+i6cs0CwwfXkymFX6/kH6GtIlV4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kfHPt4ow27saWsKHOvVSdLd/POdqzptaxf40eLvo4va/JdKFi0
 6OSKW6+l0cdF87686aByV8cHSuN18dWSwhgrg2UXYyhGMYvz5y1Sx7TSwjsuLRfd
X-Gm-Gg: AYBFou1z9MOvdcWJxZ0YOex/DebfrbRzH5ghqksrhp0d5W7dceqMBi1jYVJTDI7fLev
 w6Tn6dedcR4lr81uxHB/iHokngXvEvmBdP36+qEBjaCHK22JaBpgK/CbqILXkqbdmBREkcgVF9x
 j+oodF0Y3Ea9zHmMHpmXDAeakHVsroi9/Bm6X7SXzyQFvEnGr4DG1urqGxudQG1rIPNiQifNTmJ
 jrvEreSoS4YW0yyMq4nZ6uXaCRAJ8eJsc3h6NiAH6XaXzp4BmllsXxKZW5ZpJy/LdZARael8Dh/
 cia6x2E0bsNEvLwqe+/r+ihuH1WOsQ3Wz2wrev/9I/JpnRtHVpaHQ4siWy/Ri/E7+UnZidxis2k
 ob3SGiLeEyQi8UBL5iRmb9/hjsYgeAhrggyMgmxWKhFvgHCtqLeMHg+nssZrP8p3A7GkoAI18v1
 vqJE4ZGR0MjfuOWEWluA+U28okWLQI3uugIMcptXvlirKn+G7wmBe2XyEULlfeQYt+A/6Rlwj38
 TBMNcox1Mvf10rIleXpwdNnvAA3mEr9FM5t
X-Received: by 2002:a7b:c35a:0:b0:49f:bcb7:8e9 with SMTP id
 5b1f17b1804b1-49fbcb70a1bmr64001725e9.9.1789648179633; 
 Thu, 17 Sep 2026 05:29:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1ce79csm82621135e9.0.2026.09.17.05.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:29:39 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:29:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, wine-devel@list.winehq.org,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] file: make struct fd_prepare const and kill its err
 field
Message-ID: <20260917132937.5a15904e@pumpkin>
In-Reply-To: <20260917-work-file-fd_prepare-v1-4-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
 <20260917-work-file-fd_prepare-v1-4-b87534ca49f3@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 17 Sep 2026 11:09:45 +0200
Christian Brauner <brauner@kernel.org> wrote:

> FD_PREPARE() releases the fd as soon as the file expression fails. The
> fd either holds the descriptor or the error. The separate field is
> redundant. Make fd and file plain members and struct fd_prepare simpler.
> 
> Callers of FD_PREPARE() get a const pointer to the guard. Simplify all
> users as they can now easily access the trivial struct.
> 
...
> @@ -191,35 +175,39 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
>   * was allocated. If fd_publish() was called the fd and file are
>   * published and cleanup becomes a nop.
>   *
> - * @_fdf: name of struct fd_prepare variable to define
> + * @_fdf: name of the const struct fd_prepare pointer to define
>   * @_fd_flags: flags for get_unused_fd_flags()
>   * @_file_owned: struct file to take ownership of (can be expression)
>   */
> -#define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
> -	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
> +#define __FD_PREPARE(_guard, _fdf, _fd_flags, _file_owned)		\
> +	struct fd_prepare _guard __cleanup(__fd_prepare_cleanup) = ({	\
>  		int __fd = get_unused_fd_flags(_fd_flags);		\
>  		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
> -	})
> +	});								\
> +	const struct fd_prepare *const _fdf = &_guard

Since the struct is only written by its initialiser, can't it just
be 'const' ?

David

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44638EBFD0A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A972410E0C1;
	Mon, 13 Apr 2026 07:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RI8UrMTl";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A6D10E0C1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:50:00 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso64359525e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776066599; x=1776671399; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HC7LQ8RAmg7bI/yzALEW4YdRB8hh0C/jyOgOuDqTf+o=;
 b=RI8UrMTlWmAc8FkxwJelZ6zpt1otI0SB5ufLJ6GkkspUgC78qyq4kOPDvFGVO3KkO4
 Xy88wf36xvxMl+ztzhsePpwLU5UT6e8BwqHzXDNLrU18Q02Pcn/umJ94DqUd3v7QWZ3m
 IOUExDEn8ZvNeQ/JOFlFh3L8VH3lZuFBY3pQQdFc62wJr7wtDenACDHMK6CvKB1vyQxv
 R/6JSZ3qnK4ZmadfGzLVU+1RyWO8iNwhrQo/XvFe8bE9rHjiQBYkgOMM8MnOonnp5g+9
 hd0QLwVRib5nV9TD/rx6gDXNHp7NNJ5d9f2RHT9JBrT0ROITMWtMHFeEjKgWkc8gZdK6
 SCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776066599; x=1776671399;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HC7LQ8RAmg7bI/yzALEW4YdRB8hh0C/jyOgOuDqTf+o=;
 b=o4kRXajH7LlmjofDkcMU51Hr/ikXoXHUsc17+LpSkOIcBbyzWEwFhjVRJSnRkTKOdn
 dZEbAYUf/LWx4IW8TjWdDcNiy5bAiJFORbWQbhne6S5foym56kYNM/gJ9q7j74vDeuul
 HbbmD8eSM0gZu3ymUMQbUdIpCyuKRluk7vPGNabAfoXeqVYcQGO5w31guQ0m82Du6UI/
 wq/7fuX+k7wX6VVAIqj/Qg8YBg7Bj8qRdhRMFUdakakCJJnjyjgJwlsw11Ao1K8zxU+P
 fXYVqACkHL5CjjydL91pflwN7FiOJq4sTsnxRgJKbetCjNPn9Cqv7/Q2ZZch4ox0sFDZ
 +mLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6kwgVO2Dsz0lIIzbHYal9zg6qJgmfvG73dW/w3ORHvalcPpf5jUgmRr5g0IdMZumD2HtAyvqVZ70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZURBGe8dLrFeMbN8T+waEBJagi1UmL0kg75xvXfEr6PpMV/Ff
 /D2gfmf5AuaS5GWAyfwBkBf+n05J+5rAoVn/ne/+ju+zmjssFY+1eplr
X-Gm-Gg: AeBDieucZ1KaAvDaxDwhDqz2f20ql/J778K3RbfKNodscSM0dDLjXTEkFPKGJCvyA7R
 6isd9XeFlWn+GBNK1C3pC6PPvc4upq+UfqoQ2awNiGug1mrYaUnZMneBa5o/ik7ct0KKAUHdERz
 Ie7qk73EUaDpEF431/9U12b+ZQVQunwkbX7/t4C3cREu2t5rvNOdXXRKxO/7AiX5v663GbkCISm
 eflMmn3iyJ+4hSzihPGlGzXSAznYWed8rot6PgLRCPt/DB6MPJ0G2HGgFRoOCckTeSlhWlkAGVz
 hUpNFPp/De6pCPdWkNDX3BsYVTRnPRwOMSHy0740vIAhtW5vd9WWuo9GlDeHdxsqiW03vp7e7+q
 zLSGMqmwTPvLvzbIkw9w0jZLbXxVhzehkgvnwunRLHemVf03xjet0yAYnXajONZCYoGCZiF38Hp
 0ulr9IbYiLkgLc458V1uM=
X-Received: by 2002:a05:6000:2212:b0:43d:795d:5dda with SMTP id
 ffacd0b85a97d-43d795d5eb4mr2951035f8f.2.1776066598511; 
 Mon, 13 Apr 2026 00:49:58 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5062fsm29721599f8f.31.2026.04.13.00.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 00:49:57 -0700 (PDT)
Date: Mon, 13 Apr 2026 10:49:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use %pe format specifier for error
 pointers
Message-ID: <adygIkRhnsGv-LwM@stanley.mountain>
References: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
 <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com>
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

On Mon, Apr 13, 2026 at 10:03:58AM +0300, Andy Shevchenko wrote:
> On Sun, Apr 12, 2026 at 5:46 PM Mahad Ibrahim
> <mahad.ibrahim.dev@gmail.com> wrote:
> >
> > The %pe format specifier resolves error pointers to their symbolic
> > representation. Previously %ld with PTR_ERR() was being used, %pe is a
> > better alternative.
> >
> > Fixes the following coccinelle warnings reported by coccicheck:
> > WARNING: Consider using %pe to print PTR_ERR()
> >
> > Testing: I do not own the hardware, therefore I could not perform
> > hardware testing. Compile tested only.
> 
> I don't think it makes any difference for this driver. But I am not
> objecting to the change. Up to Greg if he wants to apply or not.

I always like these changes.  I wish that there were an equivalent
%e which printed error codes that weren't stored in an error pointer.

KTODO: introduce a %e type format thing which prints error codes

regards,
dan carpenter

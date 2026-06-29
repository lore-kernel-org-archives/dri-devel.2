Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B8DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435C210E71D;
	Mon, 29 Jun 2026 07:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LG6R9fjX";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9133D10E71D
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:12:01 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so635268f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782717120; x=1783321920; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=14U3oSmp6/cxdfs7VbabXG2V4XXAB0Fo6JU3//lbVyA=;
 b=LG6R9fjXAcFMlymy3IC/jwEtU5xNySjQYXHJlixEq6yYIcrIbr30ZHZhAEPRbpoQe+
 6wAjerwPTt6KwWWUUfH6zSXilYZqE9fY45ztTJCmLej8UwuzSQbOt1noaBI0wqUNGbST
 pwvbXyJzSrluOxRfak8BWG2sASKwwsJjMJFGXxGC6+u29gxJXlX8j0ZZX+AoXnSbcoj/
 7MDHq+H4+WWvxtcFtkomSdyl04M77i2VCxA6zc411jgVLTa+x43GYh3V7g8jDM5U+JZy
 z8/spIQTQEu0/3dJpKe+vB3J5deMdyY05rbF1a6G53SQzhuDscazT6lRJLnZsof8KcLJ
 O/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782717120; x=1783321920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14U3oSmp6/cxdfs7VbabXG2V4XXAB0Fo6JU3//lbVyA=;
 b=SCzhaFXjgdaFVR+1lPxqZia5mSvI42JxOLRnQ1AgTd4NdUcRxDnn0JrFy01w9D1Ebs
 +angLzRPfu7AfxSp0cS98eU8EP3S0xhR9gzZ8lnAXtSWicEuA9zpnkievt0/kY3L8T8Z
 WgyaqeVoPOWOi1prhG2L8Z9l7C3Ye4MFtDcWJfsn2glpAx4hexItayYbJq5jB97m6mxh
 c7Pxav0WGpoffKziJPfTTB/NJV/pSCVajItTjMU47/dQ/sClbKPYzl9tAfslmJFxNc4Y
 TGbG7l3onxWqV0mkK8EjS0L4cul7PH3IAHIDWexnALNVh50RUCgNw3DLMoAXzId3VX+v
 34YA==
X-Gm-Message-State: AOJu0Yy7Gcl3mgV4rcRBZgR4fXLZ3ebGsnjwRpBUvbr4xbdjC/fQ1JPP
 0q7PXLKTXldd0PWOXi+2/+N4eYg5DzZS5IrhvfxkRQGETnF1aLtJ7lWh
X-Gm-Gg: AfdE7ckBj91T1N5vQeg2UUGVsECX7zPiNcUMjXnf8/NgV+3HwSbxloLf1MlGvL0YV7L
 kqsWYmx86bhzl7ZjJ7tekmNVCWNUBtLeN46B4KeVwRmw/MQxmezr/Xc6EjPP5yGNhp5egWQfkPa
 cHyiPSX5D/IuCm1Cx9X8pr8rUJZTD7JAJ4oRK3O1qS+IZ7qJSi7NReV89caMyQ+vbdyPIuIJ4Si
 iTcSpAd8uJVFsOEgk+ENbNuOTFJWOWk8jpfz1YgRvbLG6K0GhCm7JQWCHwTHkFrHnmwBdrR8+CG
 kvV7wFylL7Oc2MeUdSBO2sWS5/vQzJlPVOYmOtDIerIUdCFH1A+9icZAILwnzS8Q3r3H+8c+UIE
 631yoo+GOFvyxR3G8k80/kgUdr/LiBGbTZNQn/ahbeTWG/4QA3JugW9/xsxvvaz8zRc9xOl7Z1K
 cpHA32oUcnbA==
X-Received: by 2002:a5d:5888:0:b0:460:6b12:1783 with SMTP id
 ffacd0b85a97d-46da706dbd9mr24010558f8f.4.1782717119929; 
 Mon, 29 Jun 2026 00:11:59 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:9cf4:43df:e612:817b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-470f55acda0sm19216148f8f.23.2026.06.29.00.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:11:59 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:11:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vmwgfx: Fix NULL vs error pointer bug in
 vmw_prime_import_sg_table()
Message-ID: <akIauwCZJNQwGrI_@stanley.mountain>
References: <akIR3WlKLCiCTb5T@stanley.mountain>
 <20260629064342.7FB8B1F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629064342.7FB8B1F00A3A@smtp.kernel.org>
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

On Mon, Jun 29, 2026 at 06:43:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The error path unconditionally returns ERR_PTR(-ENOMEM), masking the actual error code from vmw_bo_create().
> --

Fair enough.  It's better to propagate the error code.

regards,
dan carpenter


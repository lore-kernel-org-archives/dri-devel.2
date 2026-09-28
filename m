Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E29EC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDBC10E878;
	Mon, 28 Sep 2026 09:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bf4Ga+Rj";
	dkim-atps=neutral
Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com
 [74.125.224.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0EC10E878
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:19:56 +0000 (UTC)
Received: by mail-yx2-f39.google.com with SMTP id
 956f58d0204a3-6755a6109c1so5455d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 02:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790587196; cv=none;
 d=google.com; s=arc-20260327;
 b=NvWQUgmzZZ+YUHSOgsmQcofwTpKCleNYGlFXpcWvEYJbjq7c9BW9kMVNFfz/4/HW8K
 cPrOpWzqauZTlnLjZnfpRuFJkEtH4ZInlb80PpGeJjJS9oB6ns92aVXS9zxi3m+kK0l5
 a73vvzAVZpZdyw1nbCRJco9lVMhrb0dYHcTZtZ1dC/C/K1bJaep8gjfpzZ2pY5Vutt73
 MP84PberW/N9MmNqTcclB/hT4cQRfxvwj3RqcFwrs0B7lK67J97j0wA+xf4CuThldOYH
 Jsgwwvw8qkTWNdbxdfl70MOpsKuY6ov6ZVSperUYLF4SlAVNyO6VSp4Qane7KaFFAK9v
 TXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kNNTZdNo9rMeYPIlppeyIuQw9iUN3f9leJevelva1Lw=;
 fh=VDwNvADIQgT8IXuPUrinUDIwvt6Xqd/SitQzKvrD8Jg=;
 b=TeqGpIeiJmyRdJGa6FDazDBVGui/2zBHecy6U+xMKt+b6Phxl0rw1VSiVDkSX/JK1y
 YsiL9eWre9J6PT4qy82pVOHUM/yRgUtANAl7tQopzV17OvYWUuIFa1X1G3L8mwQmbJyS
 WRF3H9Jy1tDMRF/++/xyP1vNqTrhect/ms062ShwUwOlWnRc5bXrpGHy0gk/0IFbvJgy
 DlnOpdYVnBbyWn32q8zyf7wzu+EwltioUotg9TOV2nZamvetTBaN41B8XDk6TvPU+nPo
 mgjOOdKSDf1REfgTAekbteY6rE49po2vtlCbrfp43OopW3q1TTvDrjpNGwA2JJ6n8iiX
 6pXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790587196; x=1791191996; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kNNTZdNo9rMeYPIlppeyIuQw9iUN3f9leJevelva1Lw=;
 b=bf4Ga+RjjQgNN8UTzCelJMptB18+8MWvwyodbIP4Mp9k04TPUKirjzzMElmdJRj0nw
 qLGjE7IQmn3Rj1SLE07THb12xYvXdBqoltc2IdGELjS3Hs30r+DoYpLr0TU3j/wtRkmc
 uN/smtUYAKyUMVt0l1jSH81+1D3x7jNIDHMpXHWU4OiG5Jv0akjfGdjU/ukkiPkm7LT4
 dXJR3a+T04zWJq6drBVkvugnXVRtZhOFD0A8yYURNmRp1vBq/RvV6LiqdCtau+evY+7i
 VjSpDDmig8UHNwpoyFpCXn/QF+VdZ/FT6X9c90GtsixWmLAt7/amwtnFAaHVwp1xXlEM
 7YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587196; x=1791191996;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kNNTZdNo9rMeYPIlppeyIuQw9iUN3f9leJevelva1Lw=;
 b=D6UvJ6ZtfrCef7XFZ0Wn9v9y31ZcIW9l60/X5WHKPPEP4/8+IuTZfqal3NSMnYFUS3
 UdLkF9k8mo1a/BivFUsQtfcD/Sp2JttGeKI24/TMlNwdDv83krjwnjDCLjJonGz6pQxR
 ImpeQvAoJVZ/tZ6frUmyL8KudLHmoAca7FDM2baIF4GoHzuzfFgJuXCvTPLr+BVaJ92R
 3Bb4GN1Y0hgQmFQUiqZ82esZBYx9lgW29yXGy1I8B/rZTYrtCGBg+CK5GqxAsqAb7jzx
 8GUselJynkUc/mHZq8GkGLIZme7CB2RfWKxIAtRENpVVgnafFkpnMU1hUhr6zNN/6Lw6
 C4og==
X-Forwarded-Encrypted: i=1;
 AKwUvByVB7XfFo42RcRSB0AYb1tpfCNeMnuNCgO1c5bRt6n2m+ynnD7PNAb0KxlIdvvmPZTV5kjtNhIFVM4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK5mh5kPf1lcMKVO98r5Ho4ECOpMbBR1OzP9mUcIIlXprX0zEB3
 G6BzgFLGFUyz+kVo7l5VOpEmacTaBAmEWCPYfE9paUstGJzFxn/e6p3GQXpFMJaKQ6u/QwZAqCQ
 yn2I7udmg1v6H49TzbZxBr6twA8xWXhg=
X-Gm-Gg: AYBFou0idRuW1mXuQWj6WbYP8bpNNJr5u3czd1iI2XdthrTegtg68lIWKxgO6/cLSg2
 kFAmi+/ZBTo424WpinGSnAqE/k6n5JFSIWP+kwCJsiVZEf90MKvEmjvE/tU07EMDHzF9i/wGHdq
 NIO5v7TAoFCkBl2ScLufVQ+5lgjQEw1My2EPIx8zthiM06FGG7ta3+A5tiM0iBDGxpOv9AX/D7i
 e7ziDcZJjbhpYX0mlXWcSnek7KcUA+dav5mAkqcwLlGpx6jxVk+8JMpJiMPyJdBRCvU26MXytdc
 gwudvuPpU5eewRFjHyaJk+k3ZMReXF87mPYVDBoS10I2XoAqAcsFSv7Q5yVIcvs/dMw=
X-Received: by 2002:a05:690e:4089:b0:674:aae3:8528 with SMTP id
 956f58d0204a3-674aae388damr2080262d50.37.1790587195700; Mon, 28 Sep 2026
 02:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
 <20260927-pvr-fixes-a-v1-2-7f5b18ab989a@gmail.com>
 <661f8ddfda9f5cb3f0c23d4594fa912b9ef2e2ff.camel@imgtec.com>
In-Reply-To: <661f8ddfda9f5cb3f0c23d4594fa912b9ef2e2ff.camel@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 28 Sep 2026 18:19:43 +0900
X-Gm-Features: AclHuK-TWrdXWb66WfcrQ4B5bq2__80Eb9x9toN9UFV7dUY5ijmxw7Myy-UKG4E
Message-ID: <CAKbEznvPCFpf-HqD95v_8dZSZna3BPNZcrHjUZReBHToROPROA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/imagination: Fix pvr_mmu_map_sgl() overwriting
 its own error
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
Cc: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, 
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
 "mripard@kernel.org" <mripard@kernel.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi, Thanks for pointing that out, I should have rechecked the tree before
sending v2.
Sorry for the noise!


> This issue is recently fixed under
> https://patchwork.freedesktop.org/patch/755273/. Please have a look.
>

--
Thanks,
Gyeyoung

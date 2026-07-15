Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8953BC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79E510E221;
	Wed, 15 Jul 2026 20:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rYKK2eBJ";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8A410E221
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:44:36 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b8d99342so5135e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784148275; cv=none;
 d=google.com; s=arc-20260327;
 b=JVADwqxKO/4J2AUAl5DWWyB/Aa5M8PPuZhD59/x1XTGGvv5paUjbUib8bCx8EKbisN
 tJep2/SRVPkFwGOxVQnnoRRN2mMDGdLBEIwKrrTnhdJiIFisjaXM5xfA4ffjrVIbrjv3
 j2HOg3XoGyIu1EQv1oyHZQ/eyVBhLW1smo7/Zk1j3SrbeQ6mByg0NL4RAkvYNvXX/iCj
 P4WFk8B54jil3Uqo7/49d4kM8aLtN5ZO1NBUv7Dbv39RoyRzS52cvSVK6EnmO82o4Q5h
 T0TEzOwHWrQzBKu8T/SfNoKxt2Spb6DFgLUL2jFwKmHEMt7BCk2hFmfLT6toe9XG1nuV
 fJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hz66rWG1l8090hWA3QPVjjyCjLvMjXWnoSa5qVyf/ME=;
 fh=mW5BHMTwxO35/01p1eneo8FNMXgK+g5508KcWMPtbwE=;
 b=KJbKke/qzcoXlv9JYiCZFquPXwdMemABcjFIxzDOwBCC1ELOkYM039SND/SIONZ2eO
 H3uOaTO6RN6yz0YmCS/520eGCZTthjTLbjdwP+o4swC8CHE7iIDRFRWvdQr3GMrGfIaB
 PEMkbh4sVhk9QWRk92TaQm0N8qO3Y4jts9leyIMSu2QeuENlr4Sfw3ebJQDa44kjnh2r
 UgiAuAK4ASghP48EQ5IrHJ6QqSG9q/enHbWiFA6kFpFG6vC+rTtW7D17zTO5qZBYTetH
 8x5IKNEMDzPmFUHJVRw0b0XRPXTonyexGTQduSmFiNhvCzuLMOqM/5jPGvROj4x2jMj0
 2f2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784148275; x=1784753075;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hz66rWG1l8090hWA3QPVjjyCjLvMjXWnoSa5qVyf/ME=;
 b=rYKK2eBJD57Tp/P6chQgcd/W8hCM7hvMbAK9jg/IN89aw5Uvre3/cWxbykDdgAqDwh
 9jR013/MDv7l+CSqr9WHDh8JcJwQpOtZcixjY2MMAbVYQGOLW+OrxWHO9TkzvoS3lRIn
 9oiyUzpNi+7E8b2FFYY+/6QBl8z9ji3Lrd4+eteutK5+Xk13gWVzhfdqaKA1IqBIcWur
 IDlJcNKTQlWplY5d9pe2aMb+cApm9ln65R/jMKG/ZAsqn2WX8bcJxU6WsmiTtI3+FJCJ
 kfbPshdcgrPyPv2ehPw7BkbjdpDjjx2LtUCAFbqSJx1ke0L5oDHN+23uwHFGSsj0ClG/
 u2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784148275; x=1784753075;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hz66rWG1l8090hWA3QPVjjyCjLvMjXWnoSa5qVyf/ME=;
 b=cOPVrzMVLvmdVFVH/dctTY8ie0LeCnFTz1eKuojCdmuch49CZbWoUCpDsTngf87j5e
 Dnl8jt81LH4yKJu8GbEgMLAmmMHrGPCCSag8w9Suj2Oj8lURr7GEzNHDpW4H+04w1rBc
 xy8wQkbKgsK2FHs5Jl+1N0QRDD8CXc9+I+Cc1Mj8kxTWksEzWa6n5lWn0YOZC1J0v/uI
 VIVqV/ZiWx/MlaI4N3xFPPydn/KWzd+e351uL8IQpk8lKjBpDyjq7iXYIYCqlg4GSSOt
 7nke1wz/yYKXCm28rlsbJEdAK2uaMM6GRQvYzaqxk50Gce6GKqAG9wBq+tOXOb8/DhGA
 jMjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roq0WKzpWxnE7+h4z4n/5iYqV95LkZCwaLZkrtAbtlJ1zAVJ3xCGwThfQkuPfGs47iLNe9Uclckyio=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOOZ/bHPg9wumEAImgpp1H63ikzU1t2hGepBN4DmuPTvCTonwA
 6orYVsZxKxvs0oR+NHeGLFECkZ1yK7t9kYdSngprP5+f+4cC1RZlaU0jynNmPJWksxEIU4CyZk5
 KV+JG1lU+5e0JZ/enQOyeB2UlrxGgc3+3p3o8yIBS/NlTAbi+ptRpyA+dNpBo+A==
X-Gm-Gg: AfdE7cnFKSIgBWcOfc+f3pwZ0gKmoGXU+Uin2RlR2BtGQmjPqYix+plexA5WO0lhST6
 vmlcYQhKhj792bmJRaK/k+5SDd6fNQI/QNNtcJLkPPW2De8kyqvX9WH6nD+3kZCLrt4JYkP9Abl
 e9vUZFDNhn23Wo7Yv4F/0To+xx5dr9J6DD+Xdfrmb1sFITEoEhFOEnErb+ovNQZM5DOUt9AAFH5
 IFa2cQWe1/124Ej6KgM6l12tkhcp1j3Z09UpUyVwDfnTb263ZonMOF9XLpg95e0TQ3erts2KK71
 QfrUXvQfxsG+GvvInPJwNCNpD0ShzrBS/s+X6q5SaE1lr4BDZBsriL8YOX4=
X-Received: by 2002:a05:600d:8494:20b0:493:aca0:32e2 with SMTP id
 5b1f17b1804b1-49541e54d4amr246495e9.4.1784148274578; Wed, 15 Jul 2026
 13:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
 <20260714114654.3885457-3-shoubaineng@gmail.com>
In-Reply-To: <20260714114654.3885457-3-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 15 Jul 2026 13:44:20 -0700
X-Gm-Features: AUfX_myDNkkGbyCVobnhwftgr4bKDJQunXmKkyEYSc1ZZ6YoWywnkOQfYn032aQ
Message-ID: <CABdmKX2Uqw5nr3-nrSAVHGt7Nij23Mt503DBhbhKT9suN_vm+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] misc: fastrpc: don't publish fd before
 copy_to_user() succeeds
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
 "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>,
 stable@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 14, 2026 at 4:47=E2=80=AFAM Baineng Shou <shoubaineng@gmail.com=
> wrote:
>
> fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
> into the caller's fd table before copy_to_user() copies the fd number
> back to userspace.  If copy_to_user() fails, the fd is already visible
> to other threads in the same process but the ioctl returns -EFAULT.
> The existing comment in the code even acknowledges the problem:
>
>   "The usercopy failed, but we can't do much about it, as dma_buf_fd()
>    already called fd_install()..."
>
> Now that dma_buf_fd_install() is available (introduced to fix the same
> issue in dma-heap), apply the same pattern here: reserve the fd with
> get_unused_fd_flags(), attempt copy_to_user(), and only on success call
> dma_buf_fd_install() to publish it atomically with the tracepoint.  On
> copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
> unwind without any user-visible side effects.
>
> Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

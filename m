Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F9CC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8FE10F412;
	Thu,  9 Jul 2026 07:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCukvkTS";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B421F10F2A5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:35:52 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-49190e20a0cso95346b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783542952; x=1784147752; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=24xTmwwfHf8GGJ8ej4fMcb3MXrY9M9ELYMVJ6Iyw0KE=;
 b=SCukvkTS4nz4D+//Ol1E3+qUtT6l3272/4wgaIDCHmwunUVfmplEzLWnX1Av2sg2M6
 76zG2NVbvjFxKfSknWoDCBWupWQy+83xsT6fChBkgkWFVE4o988l6PO5jO+5fh/wOmz2
 gE+4v7Ysz4eeiiFg+9CpYokJTpleiBpZoU7qSkvakzcvQ3m96NY3oJhOOiVRj9Jnhc7E
 Ro3sNMARJSAIQ4X9k35oJH15qVMIHHk9ZmXkkBwvxr9zVJtYbiXGA/qmUvGsJt5ilGWw
 cVDkDYS4QCyRHg4g8WHGZHaaFirdNviI1gdKbRIHjQya1U1wb+0y9Eccd/l9NrK9TSkv
 2Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783542952; x=1784147752;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=24xTmwwfHf8GGJ8ej4fMcb3MXrY9M9ELYMVJ6Iyw0KE=;
 b=pdTE0JhKaM/ji3XOuZXeHAvpaONOcyN1B57iFf17gQVjeudNl6P8AnCYjkacWxmQvY
 UgscSk0TQKTdy2zKTOonNbeg7lu9vSU65I/vDGXtK8Rn+Q1p3LRRBOqtsGnsgE/9gaBZ
 p4ikq/jx1Bo4pRY+rwcPJ3lepoVTgi9YzJ5aO090V8llPbyfuXlp0p0zAIjd6zX5IGMC
 FM5qVYvn7lDF71TX/zXag9KXWRDYtxyc+MBUmERHJ8PGCOYQRXun/s6LLlvBymPXmU8x
 8JzciqTbmdsvEchGENaZaR6AVue5tVN28pR979nlud9iQtDKfljIBYsIhrnxdOeSt5/6
 tMoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bvyexMDHK+Ed4nwuxMc2A6b6oQ/0SIG1/+YihLtVrg4M32sxDXc9xpUQOHDyMmci1zafPULS+LBQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvNwTVnEafQXFRBG7nuyNjF7n55NRQPG5SQDn+AzNrLrippzwP
 GNczy+ft7mHdbUd+NXJ4F2RgGZ+NuVLask4MUcwqTRXC90RoACq/RXFP
X-Gm-Gg: AfdE7cnxTWSg3Q56OtrFkMC3RJdlMK6tGwbiaFJorLpr3P60JngPxENgahtJvWqr+Rn
 d83rz/HBWNpqtyUdMHez/Xy0pp4t7B52HMYUXEl/WEKs+uV2vPd5ILld5ZIky+0StumZdP3gUvr
 W4MKca/evkORVixdwsyWqoa4ijBCN8ySMBEF86mGjPKj9oqYbkyuAY61F5JNv91r3iWKyyx1pPC
 Brtr6YoHCFThRrInCIQ2E6PXM5AAz2t/a19albpTdIjoMp3jd4f2+J/pfHCbowtroGHzB/TFa1k
 78B7tz3W81p8F87inG76gcLeZj2LEJ/7bpWePyPEhXt175A1K+mEPXRdc335XVVav6GlD82Zmog
 wlwveJqxMHgMWX8m4I+qgKFA3HLzDjvur9E/SNuubOjIxoZNBRQanFfyTMlNljsK4/pG/UBEzu5
 UH7ZJ/M+xr5HwXg8QW/hxuJkSN2Q4J2U8h
X-Received: by 2002:a05:6808:6d8a:b0:486:4212:d728 with SMTP id
 5614622812f47-4a206116affmr3560063b6e.43.1783542951653; 
 Wed, 08 Jul 2026 13:35:51 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:a::])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1afde6cffsm2535573b6e.11.2026.07.08.13.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 13:35:49 -0700 (PDT)
Date: Wed, 8 Jul 2026 13:35:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, matttbe@kernel.org,
 skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>,
 Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <ak60menMXAbi/SCw@devvm29614.prn0.facebook.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <20260701-tcpdm-large-niovs-v4-1-ca4654f37570@meta.com>
 <CAHS8izNdJ1LTOr_pLjXef6Yv-=JOFPe1GcZtcbStD93Tkpy1XQ@mail.gmail.com>
 <15e72c82-ca99-481b-bd53-744fabd503b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15e72c82-ca99-481b-bd53-744fabd503b0@redhat.com>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

On Wed, Jul 08, 2026 at 12:50:07PM +0200, Paolo Abeni wrote:
> On 7/7/26 10:36 PM, Mina Almasry wrote:
> > On Wed, Jul 1, 2026 at 12:22 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >>
> >> From: Bobby Eshleman <bobbyeshleman@meta.com>
> >>
> >> Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
> >> This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
> >> churn for large flows.
> >>
> >> Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_BUF_SIZE, that
> >> lets userspace request a larger niov size. The value must be a power of
> >> two >= PAGE_SIZE.
> >>
> >> Measurements
> >> ------------
> 
> Checkpatch complains about this separator usage:
> 
> ERROR: Invalid commit separator - some tools may have problems applying this
> #15:
> ------------
> 
> Please replace or remove it in the next revision
> 
> >> @@ -90,16 +90,17 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> >>         struct dmabuf_genpool_chunk_owner *owner;
> >>         unsigned long dma_addr;
> >>         struct net_iov *niov;
> >> -       ssize_t offset;
> >> -       ssize_t index;
> >> +       size_t offset;
> >> +       size_t index;
> >>
> > 
> > nit: I would keep this signed. Some of the most frustrating issues I
> > ran into is some of the underflowing and then passing a > check or
> > something. Although if the LLM is not complaining about this
> > particular case, there is probably no issue with it. I also notice a
> > lot of existing code that deals with indexes and offsets goes for
> > signed.
> 
> At very least the above change should go in a separate patch, as is
> quite unrelated from the rest.
> 
> /P
> 

Sounds good, I'll drop the type change.

Thanks,
Bobby

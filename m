Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E21CD8C8B
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600BF112D5B;
	Sat,  6 Jun 2026 07:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rIdQqzeE";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925B411A9E0
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:56:48 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2c0c3184c71so17204445ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780678608; x=1781283408; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=07Z9+e3inJcySCaf9Ls4BTaFTWY0Pppf5c+tjALyKsk=;
 b=rIdQqzeE465Np+z1+LVXDTlsTDshgv+l/jjSREp1y1zNwAmtfyZCX2uPwGkXa+/Prq
 BjupfCI7RHY+AptuXIxVEQygrSq9CcSVdGfH8NZqfuWtRiZXc1Lxb3idpyWxQtC/pIZ/
 hr6g4FiSu8XlsRhc0x3km2hVGHPllSMo+CQNoKF76macQVV4JfIhhJjHJlHn5XPUZl7J
 hPvW3n4uFc7lwxAFnW+YPat1ms7cN63f5aVb7V46HSLwc6+9L0w2FjgRDq2yGRs1f0io
 20lezpAQAkfZmwuCguO8iG15Aj+ticzfBbV0/yFF3bNj66F5xG0H2oPPBDmBi/tFu09V
 1dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780678608; x=1781283408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07Z9+e3inJcySCaf9Ls4BTaFTWY0Pppf5c+tjALyKsk=;
 b=FxSw1/gUR4QCd/XFCveo4PatuYckEvy1T2jJj72iz5RE4eEXKCS3N0GzD8QMv45rQD
 KURmAdZKxhHU6pOmDw1xNfjsh5E9sbBL3G+0P0hDoXoPe8d/gIPH715TV06UFX21H/SA
 BGAZl+V9bhe4xqvmQmkTqUkzFgdrmoVd5tr2S4WkHFwDCh5jQad9rfvTWBdQYIz/VcxW
 hP8owZ4C/46zEw7vM7WPuvXGlBibObBX+alrx9985dxw+ES/iEmjU1T6l9qPwd0SpGVF
 iSZv19pbSeuUDpWhwRJYCgfzwCondsCFYRxCii3Y74ytgb0I4fiFei16NN9ZOgmBGUmG
 NHfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9bbc2n+mve7/7FMG8YBhmtkjeHIXNXpVcx+VR0g3J+NykKz8/zH4X9wiGtbEkK9C95J6W444tiRM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxfeej6wWpT67ciEijsJKqhP6fWkDP5myoXQCHKzNFVlsaeJiZc
 D+oFDjk6H359xnFbOPszemNB4NrRFfVk44a3CoEeDr5wedJLX4gh6MOc
X-Gm-Gg: Acq92OH3RJGQWF9gjWwpS9Rx4RCjNdd9xbaFZSv95NpW+z+jqSBjNvW+NTU8Tbt2HMR
 PhURIWvBwtsHLPkMtqmuoU7kOqyH0LwWQ4La9867RTF7fQ4ibMrXTjEKRJjIP379EGqSNOqwuXI
 yb3fMR9a+frjiyQ/zI+XugqoIQHQLZ6ghU4ESN+jYvXh8o5dIU7ygBDoG+n3Ys3IRjTVcto8PbL
 vWBJ1jtjI2rQyIAMA98ZbFmA+D4+CZ0/nAoYOam7OGNP9KRDUosekyv8qyHGkjZNCtzQLCE4RfW
 qEzvsUaNLilQ2vEGuTtZUVX5SAliB0Il3jw/Ab+0oL1U1Q/K7vdHvEL605u1vDLXE6m3+K7L+9P
 A6SoyMbNX+kGVhqioscFmj4Ke1CcVwZLi6Bit6LhwB+F++IPd2VcKzVgNk5eibD+9NefiSXxTn5
 77oGfE8cDeEghsLf432h3paGmHbWGH9eLKJPbSE/vbMxWggfAMZ/7TxkY=
X-Received: by 2002:a17:902:e790:b0:2bf:379b:53ed with SMTP id
 d9443c01a7336-2c1e821e5e8mr49794665ad.27.1780678608079; 
 Fri, 05 Jun 2026 09:56:48 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:71::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6dc92sm89653455ad.13.2026.06.05.09.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 09:56:47 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:56:45 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 3/4] selftests/net: ncdevmem: add -b option to
 set rx-buf-size on bind
Message-ID: <aiL/zQe7Ku7bKIJ6@devvm29614.prn0.facebook.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
 <20260603-tcpdm-large-niovs-v1-3-f37a4ac6726c@meta.com>
 <aiLsegSEGviNluv1@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLsegSEGviNluv1@devvm7509.cco0.facebook.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

On Fri, Jun 05, 2026 at 08:35:25AM -0700, Stanislav Fomichev wrote:
> On 06/03, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add -b <bytes> to request a non-default niov size via
> > NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE,
> > udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
> > hugepage produces one naturally-aligned sg entry.
> > 
> > Reject values > 2 MB up front: MFD_HUGETLB + udmabuf can only guarantee
> > 2 MB per sg entry (one hugepage), so a larger rx_buf_size would fail the
> > per-sg length/alignment check.
> > 
> > Add CONFIG_HUGETLBFS=y to drivers/net/hw/config so the new path is
> > reachable in the CI kernels built for these tests.
> 
> I vaguely remember there was also some kernel cmdline argument to
> reserve these? Do we need to also do something to NIPA to reserve 2MB
> pages for this test? Or was it for 1GB pages?

Good call, my little runner script when prototyping this adds these
pages at runtime and I forgot to move it into the patch, we can have the
py runner do this setup.

Best,
Bobby

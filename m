Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E36CCD98F4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E284F10EE39;
	Wed, 17 Jun 2026 07:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nem46vzL";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385FD10ED14
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 21:59:16 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e6e9408e30so3637318a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781647155; x=1782251955; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MdIhJ92yHcSeuARKRFApaFACq6jQgJFrqu8oVo70t/I=;
 b=Nem46vzLeN2Yum696uh7nLpzXZXe3IGj92BZHn5LBKF5D39UQW1iRYtzm03r/h8yde
 Bxku+J+KVzrVi6rF4FviogAHqme8dZ/8OlDpUSL1nV+lBaAqtWBIDDzmasL6iFDA0zOC
 TT4iP3PCjy8UreMwA0AbhMoDybfFenpDixOPQbcFl6ngtHO3mk5pu32j8M0jnseM3iQm
 OfHjwYKJMslkDpCkjMtvUIyaWLgtxEX7EJlpF1MLocHfy0NXGYDjdDVLQRQviI2brf7F
 KKoHbPKoJUATLt7BAWXWOLbkCbbtNZf5v00AxxdHdameDuYrJQk3V8AIXei6h8KpOGW7
 E/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781647155; x=1782251955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdIhJ92yHcSeuARKRFApaFACq6jQgJFrqu8oVo70t/I=;
 b=EMsiu27oFHwl/17HBnTh1yQr47dL2L286ICrSai0nsd+hsPkL/uEAab/Z3hW8xf7fl
 CHhtaXj96DhF1xGlg+kjhiDywHJub0QCJBIoBq8AjdWKkD2AjBupUTVt7I3CdqtTCBgN
 GTvdPMUsQVBexDcxi3BmfL3MExh1NBU+BGiOZF1+OHiFptw8IX/eg9OPXSHo6452bd21
 KLsUkYyTE6PK2glgVjU+g/SReNQ2/y41EwLC7pedfa4hWGoShVwSYSqaw9NL+xLEGZRP
 JjoIgaVGS8QULEBbCHyEfJ0ePexmz6DLMXVLZhhufFMBgjWRxoI5RIe165RFLz0ZhtAs
 IKrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Xbkh/aIDnbrpclJuQZY1iUWQijHNkshVq4Zv+Xb58Yr/eC39FYKKnXx9MMkcGMNOyStCKHi3pIuI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7f/xzCKltIRbpwjD/3kpG4srwxtazar802WOGxTGEUaSjbank
 Mi5MTY7/Bv89TSACzK4kYwC8Gp+8i2S3cVfuPnMsUsNvS8e23jCySsDs
X-Gm-Gg: Acq92OE3Y2QTNoK/NxOk8rrBpnLC4/U312zQlF5NE0x8FxEs4Qvbs3GbCcMEUaXjeBU
 6NPNcaxCtEmLGixOiVIau1EztcSeGKBHHK88SFPPCT+EM62juefd4D+AhfrsiDEHvvshdZVc61j
 PoHm2+Wj6LGkIIi4auuyY50+FdPp7o7C7sMeH/xo6kAcKF7qEX4eMpjZGV92QQML02+5YzpIv+3
 QwU1WZnM4MlDrRqgzxbthbN7ytSh5ezpWar/toGvg+gF51OMnL43aRR4sZqKGEl34S3QWTjvmz3
 t9CYFDmDr6DL8JjvmiBKkl93fVnghxhlyvK9IouaD8/FQtoRY+BTqlaLz0meUsw/qQMn3GphDWb
 W4wZTOxG/Ujzdz5b/yzHVQEQ5egY+2nWWJ4KZa69R898feYUxaqDGPiTGRgc23ttPV9ei3zNNhl
 +MJLUcXT7cRC+Q5nqUtylfESs8Nf5yrwcPKox8qfeTSl+G
X-Received: by 2002:a05:6830:2783:b0:7e7:352:2f74 with SMTP id
 46e09a7af769-7e90b43fae5mr1228845a34.13.1781647155303; 
 Tue, 16 Jun 2026 14:59:15 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:54::])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e7a3c2b08fsm6625336a34.8.2026.06.16.14.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:59:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:59:09 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>,
 "razor@blackwall.org" <razor@blackwall.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "almasrymina@google.com" <almasrymina@google.com>,
 "matttbe@kernel.org" <matttbe@kernel.org>,
 "skhawaja@google.com" <skhawaja@google.com>,
 "dw@davidwei.uk" <dw@davidwei.uk>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
 folio
Message-ID: <ajHHLfgY+pZ8AD97@devvm29614.prn0.facebook.com>
References: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
 <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
 <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ajG4zaK9zu7qZT1+@devvm29614.prn0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajG4zaK9zu7qZT1+@devvm29614.prn0.facebook.com>
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:07:22 +0000
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

On Tue, Jun 16, 2026 at 01:57:49PM -0700, Bobby Eshleman wrote:
> On Tue, Jun 16, 2026 at 06:04:03AM +0000, Kasireddy, Vivek wrote:
> > Adding Jason to this discussion.
> > 
> > Hi Bobby,
> > 
> > > Subject: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
> > > folio
> > > 
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
> > > underlying folio was larger.
> > > 
> > > Instead, walk folios[] and emit one sg entry per folio. When folios
> > We have recently merged a patch (that will make it into 7.2) from Jason that
> > replaced sg_set_folio() with sg_alloc_table_from_pages() in udmabuf driver:
> > https://gitlab.freedesktop.org/drm/tip/-/commit/5bf888673e0dda5a53220fa0c4956271a46c353c
> > 
> > Since you are relying on sg_set_folio(), the core argument against its usage
> > in udmabuf is that it doesn't work well with offsets > PAGE_SIZE, resulting
> > in a malformed scatterlist. Not sure if this can be fixed easily.
> > 
> > > represent large pages (as is for MFD_HUGETLB), each sg entry is a large
> > > page. Normal PAGE_SIZE sg tables are unchanged.
> > > 
> > > This is helpful for importers like net/core/devmem that expect dmabuf sg
> > IMO, udmabuf needs to detect whether importers can handle segments that
> > are > PAGE_SIZE and set the entries appropriately. Please look into how the
> > GPU drivers and other dmabuf exporters/importers handle this situation, so
> > that we can adopt best practices to address this issue.
> > 
> > Thanks,
> > Vivek
> 
> Hey Vivek,
> 
> It sounds looks like that patch might solve my problem. I'll apply and
> troubleshoot from there.
> 
> Thanks!
> 
> Best,
> Bobby

Good news for me, that patch solves the problem. Thanks for bringing
that up! I can drop my udmabuf patch when I respin the series.

Best,
Bobby

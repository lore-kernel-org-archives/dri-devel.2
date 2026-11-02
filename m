Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F1606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bUXZn0vj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A5510F15B;
	Mon,  2 Nov 2026 18:59:04 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53C710F15B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 18:58:58 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3698bd5392cso2892907eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793645938; x=1794250738;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NbysLIrexph35LgjM0FGUGuc+zi/f3zUiCq428yT1Rk=;
 b=bUXZn0vjt7LrsOn4/vzBbAqTnlIbll4hg+9ijLJx+bv8w2OWUpPhSNcpOTBFtXuLPU
 FYf4nDCDtf891md+JYbV6GQ+PqTmfUF3hb/b9DGzUtxU1zwZ/M23jGr8eSCpaUbeGInK
 Lq/sPUd5KOmDX+kfJhR2NgUrt4NLVki3PrdymFkUX+RQAmLAixXfsPIpkJekTtLmyCIG
 Vsn9uSz5S6v1AbnFF2IWConx4haP6LlQBjeQVwwXdgi0h9/OyiyLvOuqrETjUnJ9AVdp
 jakWEFg3J06xzHAfDwcah486v4wg5uEzTGjzMEMhhIKZdOSpHaRb04J+/aymF+bs8PjP
 VlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793645938; x=1794250738;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NbysLIrexph35LgjM0FGUGuc+zi/f3zUiCq428yT1Rk=;
 b=FGRDTByYRTQxB1CNYSuKKtubWdSu7p2EEM3U5IEDpKulzqnWy/iqwXlzrZe+rdHQ8M
 j26Jn1fxNDB6u/8vd2m6YNBRHGrGtDvkyZl1PU2w/I9dw8fCd4ZMqUTMrrtE45FGeyYE
 IFNFLmVGXxfTPueh9+C1WLbiptH0PAoOuihrkMzHya90YmK/N4Xb0bCrUmhjopktIl2s
 zYcGUVVNPRIBBXSmFxadQu2Chq7UMNFExPw4tznUKRkpkGEpn8xkt3kC1d8z0o5zX2vW
 Pn57wM2jOFwiWNVs1mEvX/ASN0ZVdqXABZokFDqkcfqq4F1zvSK8Gt4wk2SbxtjnZl5j
 dobQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4TLmcyRV1frDl8ba7VVbiXAdVbQ7wFHvFkr22gMn9icixg8jGZhdwJqQb+8opt6LJxs0oJdIvh9M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8KyVTRuOPffmABX+mQL64xCmskLn+ZJDIeF3RJSI1kAHQCgsdK
 Q2doM1rxruAORsSFP2ekCJQLU6nM9o30/kT4nKTsR52j7IxC7BgXbFnS8k/dr2rAxAcVuGqrzFs
 gIIxb2xeCci4L8Rp9icBESKIw/A==
X-Received: from dyjo24.prod.google.com ([2002:a05:7300:3398:b0:359:198a:8046])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4d12:b0:369:dc59:7a6f with SMTP id
 5a478bee46e88-36a422042d2mr15472016eec.1.1793645937269; 
 Mon, 02 Nov 2026 10:58:57 -0800 (PST)
Date: Mon,  2 Nov 2026 18:58:56 +0000
In-Reply-To: <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org>
 <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
 <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102185856.1824792-1-almasrymina@google.com>
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
From: Mina Almasry <almasrymina@google.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev-bot+sashiko@kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, sdf@fomichev.me, kaiyuanz@google.com, 
 kuba@kernel.org, bobbyeshleman@meta.com, asml.silence@gmail.com, 
 dw@davidwei.uk, ap420073@gmail.com, davem@davemloft.net, edumazet@kernel.org, 
 horms@kernel.org, shuah@kernel.org, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, phasta@kernel.org, andrew+netdev@lunn.ch, 
 sdf.kernel@gmail.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
 daniel@iogearbox.net, razor@blackwall.org, tariqt@nvidia.com, 
 kaifengw@google.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 7:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 11/2/26 00:16, Mina Almasry wrote:
> > On Sun, Nov 1, 2026 at 3:01 PM <netdev-bot+sashiko@kernel.org> wrote:
> >>
> >> - [High] The dma_dev use-after-free this patch says it fixes can still
> >>    happen for RX bindings made on a virtual device that leases queues,...
> >>
> >
> > I know about the issues with leased devices. That needs a bit of a
> > rework, which I have done locally, and would like to send out as a
> > follow up fix.
> Will such follow-up rework the code touched by  current patch/series?
> how much? I'm under the impression that at least the fix for the issue
> reported here would be quite overlapping.
>
> /P

I pushed the follow-up branch on top of v5 here so you can see the exact diff:
https://github.com/mina/linux/compare/devmem-teardown-v4...devmem-lease-bind-map-dev
(commits: https://github.com/mina/linux/commits/devmem-lease-bind-map-dev)

There is some overlap (~55 lines of v5 touched across a 6-patch +262/-99
follow-up): it renames binding->dev/vdev to binding->map_dev/bind_dev, passes
the net_device explicitly to net_devmem_lock_dev(), factors out
net_devmem_close_rxqs(), and replaces the !rxq->lease / !netif_is_queue_leasee()
skips in net_devmem_dev_unregister() and mp_dmabuf_devmem_uninstall().

I kept it separate only to keep this net fix smaller and easier to review,
since the lease issue is pre-existing. Happy to either land v5 first and send
those 6 patches right after, or fold them into a v6 if you prefer avoiding the
churn.

-- 
Thanks,
Mina

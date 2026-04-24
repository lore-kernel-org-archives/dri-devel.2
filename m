Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFD0FE51ED
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC98D10F43D;
	Fri, 24 Apr 2026 08:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="VAwtGBDd";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQKHbfZw";
	dkim-atps=neutral
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9558510F43D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:59:51 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 92E997A025F;
 Fri, 24 Apr 2026 04:59:49 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 04:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777021189;
 x=1777107589; bh=mlomHPrruE4T+ys87B/weKxrB+OMcheSKA7ybwHe8Os=; b=
 VAwtGBDdupJVNcGs4MDYlHN/jcjRLczK3kvxLgWoQdqSNpidCbOM34UZdtC47lPI
 3mzLU0zrlTFvKZ4ByH4LX9Kc74D/yZouVzPWdHMwcRR2I1feKTWewWA7tTWI+ZJn
 PrCivp8NoY5n6WX3mrTswbFq4VmW/SNE7TH8ixsNpRyhFWyWMFTL1KmtdlIq+YV4
 Kqd5RjvlVW8dM6YHO4uaay2H+g3/Hiwvkb+D9ydasIbOygdMJBl45LE1dQLMPNks
 e6uubMuXLbwSb53dOAF6N0Z68dFgeLj6Sr8wJEC5GhRXlY6SxMikVtgDQeLDHKcT
 a6xtaaVwbYWaDHF/GgPeYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777021189; x=
 1777107589; bh=mlomHPrruE4T+ys87B/weKxrB+OMcheSKA7ybwHe8Os=; b=D
 QKHbfZw7Q2sK5fyHnbXqxbgWESxL1nXYGxwluPhFn04CPG0ZBoNwIGyTlE2bmVOx
 AdU+JrNbqccmxNUNuf1Unuo3Y9MufNOoEOQUHzy/Dt0Fd1EUMAWkUy8g7wYkzTZk
 tHj6S0blQgtMsWFUzUXtS4X7Zb/ocS8a8QF/iF4O4Ff1YZL5wyy6+pWnRWUMD/qt
 6RslSA1fTW4t8AVYcxkj3Q1GOVC79Od4yVRo3O1HtUx0w7zq8/HWNi0pcd1fSOhr
 zPwSZ8Jr8MoCjwPosyG48F3HQ7x+w8nWRA6wOb4l1R5vVbrgunuKZd/1BLg5Y/O/
 PAZfYZ88A0es7wYw41N1w==
X-ME-Sender: <xms:AzHraaywWnncYS8tNhxu63w-pdBByhF1khzcFj2QqdnD_7zXkakFWg>
 <xme:AzHraRGVdgiwkNe1nvTP1k6zaX_wJ8ZkyqgdKXya6mgkEbVD7yti8eiOP4J83Qde8
 hva1xiaUorg-yfUdfieO-6I8coGh6k11H7kKx3As8c6Wb13HojPbxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileeiudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegthh
 hrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehmphgvsegv
 lhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehsihhmohhnrgdrvhgvthhtvghrse
 hffhiflhhlrdgthhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgt
 phhtthhopehmkhgthhgruhhrrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitg
 hkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthho
 pehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesgh
 hoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:AzHraU8PAM-pOR819TPN7Sy12OwyJa_bV3rrivQ1T8WeNaru67PLBQ>
 <xmx:AzHraYGd2u2SgOhQCAvkyX46Rn0Y5ChJvYTIHhv9DEn4DxxVWJHpyg>
 <xmx:AzHraTb8M-1Ggg45Cjrw2tGk-khaiCVKwHOQcW9e1jDzIcTeHgAb5w>
 <xmx:AzHracMu7nyMcdKc_oWpxYP_L21uEHKH1knniB8yVyBMOxpxXlfuYg>
 <xmx:BTHrafRJhrCm9AgwqxWvjH44g0NYZQpqxnlIVz9LfEM3RmBfYtPHuybK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id BE908700065; Fri, 24 Apr 2026 04:59:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ADiin7Vigcc3
Date: Fri, 24 Apr 2026 10:59:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Jason Baron" <jbaron@akamai.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, boqun@kernel.org,
 "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, tamird@kernel.org,
 "Nicolas Schier" <nsc@kernel.org>, simona.vetter@ffwll.ch,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Cc: "Link Mauve" <linkmauve@linkmauve.fr>
Message-Id: <b5e7c099-3a5a-44dc-bc7b-42429abe3aec@app.fastmail.com>
In-Reply-To: <20260424054742.45832-6-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Content-Type: text/plain; charset=utf-8
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

On Fri, Apr 24, 2026, at 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
>
> This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udivdi=
3 when
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the ke=
rnel
> build on PPC32.

It looks like the problem is commit 9af8f2b469c0 ("drm/panic: Add a
u64 divide by 10 for arm32") describing this as an arm32 specific
issue rather than something common for any 32-bit architecture.

You can probably add a rust version of div_u64() and use that
there.

     Arnd

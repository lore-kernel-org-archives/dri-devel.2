Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91736FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D548310E80B;
	Mon, 27 Apr 2026 16:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="LM+1WQZb";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="rcp5e0Yz";
	dkim-atps=neutral
X-Greylist: delayed 360 seconds by postgrey-1.36 at gabe;
 Mon, 27 Apr 2026 16:11:26 UTC
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A751310E80B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:11:26 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id D7ECAEC0FC1;
 Mon, 27 Apr 2026 12:05:24 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 12:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777305924;
 x=1777392324; bh=ZCtou/cEXXCW2EAHTSeZgopr0M/VLaS4+NUan7nzjpo=; b=
 LM+1WQZbjg5FBMii6wK/sxZP2lOaFxRnk3u5Y3RPRDCzwUmZITJVrJYqecL2ip3a
 4zzSTLCelWjFhL013m4iJHoxS6Qryrlltr0l0KcnCsF0zd8QPA8q6pUln4acYa8M
 54nuREiojIbbaBaMFMLGNK8a5NR9/kuocofwyDkZm5DW7GuZ/jmqkNE5M3f46zKo
 5QaTkvQGYhoJdysVmGamXRQKrpuIz7P+dDEeMSCkxebmSIF11REtmkrF47cpziZe
 zenSKG9DiD44E7jJxT04sOGvo0Hmconj/mNLbJlmwwqDLCfLgJ3JyiScecfLsZYk
 HjdD77kIDYfokvaUaH6FTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777305924; x=
 1777392324; bh=ZCtou/cEXXCW2EAHTSeZgopr0M/VLaS4+NUan7nzjpo=; b=r
 cp5e0YzGwabDnLbX/xXlbtzzv9e8OX0XRwm69dlgxbBAO3PGQDnv+gLQ9iNaw41t
 wiog0CQMhPF+ACfM6DLMRENiyAYiJeJm1+ICJB+8quz+E31tQ6nPNQPc/XBiA0pw
 n/cJg9b/IcMhSBopBJbLrEhhxyEQYKBBRMOIyStsB49kW1o929ihCOJ9oxPJS4yR
 mklaN+1vMJ3XdBzCPiiHtUvU0bqlp9z4Q7AZjFEMVRW4SXSTRkvgkYb2ToIN4omR
 5t/JFUxGzDJDq0qYmldtbIqsLrBi89KCkPrVSmT1gzvgREkXP55VsmGOAjNpoHa2
 dL7fdzim8Bm97btgfIZ5Q==
X-ME-Sender: <xms:Q4nvabvgD-Y0-q21rj0xIevp3vYtWZ1cxKFvIuxKRHMaTtQTxjGz5A>
 <xme:Q4nvaXSFnWpwpLdH3gTHczIdKeqNIYEdHjDNHzryu4ch2F0apyFIXLg61RMHMZ-b3
 304p_cMmvtBQBKrtHOzNpIgGPl-vyiY4uum6i7My8pPO5wY649nPVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejleduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegthh
 hrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehmphgvsegv
 lhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehsihhmohhnrgdrvhgvthhtvghrse
 hffhiflhhlrdgthhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgt
 phhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprh
 gtphhtthhopehmkhgthhgruhhrrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhi
 tghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtth
 hopehnphhighhgihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Q4nvacXMD2rgkFYfQT6xRfjCHHzuIur5ewWkYvLB3s1CPfPeONk9Yg>
 <xmx:Q4nvaY2Is8kGpnqdtzP_bEIxpw2iOsohNjjdyy0uXHi_Xq7T0TrmMg>
 <xmx:Q4nvaeM0ht2htEmAr3ZLvSR44Fg_2_9W52RbXTZcjuamGIomTUJOMg>
 <xmx:Q4nvaQS7xdW9MU6arMT9qKha7QhqS-7qn5T0fzYzrfcy_Nars0aFfg>
 <xmx:RInvaRzrTfYEHKqKGtWlisXUYFSpPribsTZQ5DAa5owond2lsXUold8G>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 3B6AE700065; Mon, 27 Apr 2026 12:05:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ADiin7Vigcc3
Date: Mon, 27 Apr 2026 18:05:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Link Mauve" <linkmauve@linkmauve.fr>,
 "David Laight" <david.laight.linux@gmail.com>
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
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
Message-Id: <21348763-ff78-46c6-b0eb-eedce69a839a@app.fastmail.com>
In-Reply-To: <aes7L3M1d_LvvGKa@luna>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <20260424101425.6bde0e17@pumpkin> <aes7L3M1d_LvvGKa@luna>
Subject: Re: [Linaro-mm-sig] Re: [PATCH V13 5/7] rust: Make __udivdi3() and
 __umoddi3() panic
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

On Fri, Apr 24, 2026, at 11:43, Link Mauve wrote:
> On Fri, Apr 24, 2026 at 10:14:25AM +0100, David Laight wrote:
>> On Fri, 24 Apr 2026 11:17:40 +0530
>> "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
>>=20
>> > From: Link Mauve <linkmauve@linkmauve.fr>
>> >=20
>> > The core crate currently depends on these two functions for i64/u64/
>> > i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t=
 use that in
>> > the kernel so let=E2=80=99s panic if they are ever called.
>>=20
>> Ugg.
>> Surely you can make it a link-time failure?
>> Or change the underlying code to avoid the divide.
>
> This is currently a link-time failure, which means if any of the core
> crate or drm_panic_qr are linked in, the kernel will fail to link.
>
> And since we rely on core, that means no kernel can be built on PowerPC
> without this patch.
>
> A possible solution would be to change the core crate to not divide
> u64s, but the last time I tried to do that I couldn=E2=80=99t quite fi=
gure out
> how to do formatting without it, maybe I will just open an issue again=
st
> Rust.

I think you just need to rewrite the patch description, it appears
that everyone misunderstands what you are doing in the patch:

Like on arm32, normal kernel code will continue to cause
a link failure the same way in Rust as it does in C, and your
patch does not change that. When you (or Link Mauve) "let's panic",
I assume this is was just a mistake in summarizing the logic
that turns the unreachable code from the Rust core crate
into a runtime assertion since it would be impossible to link
the kernel otherwise.

Silently turning a 64-bit division into a panic() for normal
code would of course be unacceptable, but that's not what
you are doing here.

    Arnd

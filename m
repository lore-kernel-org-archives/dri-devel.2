Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B79410E4BB;
	Mon,  7 Sep 2026 09:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vLIPyoES";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D7E10E4BB
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:24:36 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so3687587f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 02:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788773075; cv=none;
 d=google.com; s=arc-20260327;
 b=aYshIEYzuDPeAsRwrfISjA6NfM9/pJRPlME0vGCste3r+yLNJKLXD4UhQ694UZRXf2
 gJINeGHcZslPkjaKze+WNCUlB7xcH9tq0wkfxBj3WyO34EyOx3rXViQJBlqQ/UPcbDJf
 n8inBGTczk3emHAYOVW7bWLuAtH+KkxoCq3WTn92JdjHeSGsGuInNOOzptqp9td51KJM
 VzOB52GYioRF+V6v5Wf6yf/ZmDgwSd4fO6WXveUMzAgAq0JD0lDpthnxMcEkRW5XI0xT
 uT8Nbwk+IC9pLooH913uugsisV9mkEjMoia0lU+X82eyZwpNwoxJoOYhXrJxwamFclHf
 XKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
 fh=l2Ybk0UMKSr83wfNeWiTUe45/6lkv/aVIgNLWgjroSs=;
 b=DGQPSwqy+O7JOm87pdMCcNhLVRLpbwlGq1xRcz/XrQ8yHTDwJaoe/nhjMWO1FFwafF
 e8OOlT0iYvWTXqV6UD9YtPkNJcaF40yxjjPgrLNzWdonBtnpMZVH1SUsvBvIcPbVkRxX
 qR86X2lK+fdH/EmVaITTVcbgRw+PcO42agt9Ic5zvNCSocu8D6H/oSq141zlhHq08TGy
 dJP5wuCgj4V9zdRp4p1dDRO9PRd3briVaVhJ9YMogsTkzl4l7peAgjxzEM2RSgWkfZSk
 RbOHJnLkkK4exlLcIPQa6+v3IvLKfTkMXX1tG6Ik/jBSotLSzs8jH3+DHO9DA1V/QrHa
 hMmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788773075; x=1789377875;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
 b=vLIPyoESE3qyTFLLOsQ5oAlJqO1034YnD0cdQMdYfMb0QcZak1OaI7T1zdOkvj2XQ9
 jgq9w2Dsj4PfoiWYSP0ffHVnm6+TVKV6VhhECZ47NwJIh/ocNr87fyB1Wod78R+xfIjc
 TzAWAebTyWpBtuwCsuutEMyJAtwvjtabKnDt2EldssUBC5X7/fClD1BYdb2kwxziLL/y
 sguXoNDuZcjAoo6gR1Hx+GoyLYjPmIdJaAwFV+CW6ExmNHNsrrVIjAb86oy7PEJp8CQ+
 idsteZJ9ddNlWySwIlB6UVtRWGbsjifbgm03DpMMoj7NsDNOaGcoGPN4AqzhBKN/CUP5
 nlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788773075; x=1789377875;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
 b=psFuGOj8AxNn5QhwBewiorEoctbCBr2XnkK1F7s15q1sk2SFkecevVqeuyQ4MpvxIP
 CVtMb3wwLs0M5U9GU2oxafWJcLNDB5yhpS1bpOvlecbnjp1mI2PM9QExHb4Lya/9M42n
 mFPjD8WMegnzXYvGxJX9hkCSYApJjDFuIYKDA6AOj1SBPne6yfp3+f0QCI5GKv8XmG8X
 PIBTC1RKydBD3Jc5ka5K+66Jj+jFMqWrUO4tZ3rd7awioJTUjedbuJwrRfu21SHXDvIn
 h6pLKgQqhbGPdSxdC+em8Z+JaeFnPTwnaBqN31fSuFJBT9trjQTeYKNT5ZydVhTq+dG6
 7BpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyiqYS+z7QJOo3OkdWMykZQjXkp+CSr/eLiRgg5ZslUyrcvA0AtgJ7Q5xSYluWAz0i3G38MOdmkcA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kxZeTGYwgtnIKeitgmepNzYaaDsZ8gFyht2GPsgnfy7w2gPHs3
 shxaSOx6HCTIG/FvlJhfvjbN8VjJDa3bYLU6hSawVSc1Se84HEAOsozqKKK9J44kuehaW55R5Et
 j8MB5ZkT2ucQ6gkwQqNr1KhN9weG3qAnPfyKKsQFp
X-Gm-Gg: AYBFou3aHNCVrSTSNARs+g60Ecjtkgv5Pzammfo5rUPAIHVPzKA0TvnwWKvJZCcRaRk
 f/6WEmMcQRHihOS53KJNVGK0FbSawx1gzP6Kj4AGcZzrlnssMmAWmf2QtMkEiLSAA82/0HN6G9B
 ehobr+4kj0kAMHOen4OYxq4LeZel3M2lA24wQQoCulo3pyvDDObLt9KesgZI5MZOCdWdik5Wz9F
 9n8X5V8aKgCQPUZp2TJfQ/brYJSjKI+wqzuZ2S4dH96+Ej5n1pwT+3pTri10P6rDjbgUe4PC/Cx
 0HMMq918nvUAVKidOL/RT+T+PcHoAxnyzqTXco3pF2xc9gZNU3rvn+gNv9F5gMyDjou4o2KaL9C
 /XMynnpzdo1rL6KNUeH1UP5rHPvM9sS0=
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id
 ffacd0b85a97d-4858ad63a6fmr37026021f8f.5.1788773074197; Mon, 07 Sep 2026
 02:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
 <ao2WubjLtDuHvRzx@google.com>
 <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
In-Reply-To: <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Sep 2026 11:24:21 +0200
X-Gm-Features: AcwNN1V4plkowyMHAsnIxTQwxzR-aYAz331pg1N8okzwNx7uKX70uWh-YG4Yx6I
Message-ID: <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
To: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Asahi Lina <lina+kernel@asahilina.net>
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

On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> >> +        // SAFETY: We just successfully allocated a page, so we now h=
ave ownership of the newly
> >> +        // allocated page. We transfer that ownership to the new `Own=
ed<Page>` object.
> >> +        // Since `Page` is transparent, we can cast the pointer direc=
tly.
> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
> >
> > This doesn't satisfy the safety requirements of Owned::from_raw()
> > because the page may be used with vm_insert_page(), which increments it=
s
> > refcount and causes it to be shared the vma system, and this occurs
> > before Page::release() is called.
>
> I suppose the existing vm_insert_page() abstraction we have is already
> problematic, because it uses `&Page`?
>
> Maybe we want to change the API to use `ARef<Page>` so it already has to =
be
> shared? Conceptually it takes a reference count from a `&Page`, which isn=
't
> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&ARef<P=
age>`
> to be able to do that op.

Honestly, the problem is the safety requirements of Owned::from_raw().
Pages have a "special" main reference, and free_page() does more than
put_page(). It even does something when the refcount does not hit
zero.

The correct behavior for Page is to allow the user to hold one
Owned<Page> whose drop calls free_page(), *plus* any number of
ARef<Page> references that invoke put_page() on drop. This way, the
owned page controls the special drop codepath.

Alice

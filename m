Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F829606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pn/1a2DY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E6B10E2A8;
	Mon,  2 Nov 2026 22:09:00 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4BB10E2A8
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:08:54 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b1b12de661so3168a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:08:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793657332; cv=none;
 d=google.com; s=arc-20260327;
 b=Aqnqog+yj+dQTGkt6TIcwgY/U09A6JXO2CVsuL5UN8Zgt6LrD2CRPfzLfHdxWmOl1d
 uq4SvUeAYRGK/8ZJZcivUsnfLPVBqLBm6TBBkdYC+m46ylLfFFjK1HZw4NYGenpKYt+Z
 c+FVf3p3C/ILbmAgKUW8c4TLWvVFeHBHyU1xprKZwiYP5LvKLagz9QtozTsbc2DLSFgY
 QHU8YTLDg1l4VZmpuwzfUWfLXvBlw743uNzItvXZ5l/hNA7ycTKBvOZLXv11sMcUDBH6
 DRBK1G35xEXkM9NeOolEerZ1C+bG+BbXc/fr1z8SDYdBJvd2bzjSuuDybhSmsYgMaocA
 edFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=04iaPr/Q4xOZpTpewylydaBAPbXSsxNLl37nHemVSI4=;
 fh=/pN+TUbXPwbo/nXWRb5no59ZuukluQoRO70daPiNs48=;
 b=dPrX37frYmy7Mp8yKsgxQHUR46P6mILKQDqolM1oMlixfvA/b+xv9IZ9nUpIGuj8FA
 tHtOFV8KbzrzckXbWaQKfaEkoeaUxX9ofb210H84byId4s8uI+1ya1ZBVOM8KBAqE546
 hGHwfkNzp+EG8zcnYXd3OinuWVCSkF1GwWToxNhICO5m+qDcWImoS5sG25mtr0HAm0xE
 eG5KGKQaSIVgwAtamRaoeb7yIReKyiT4Sckhrmykou4BrAE0WnorCXKsJ/GGw1d17DXD
 2/y1JQCM/SplurpXfcF5FeTGqDmaJA0mNZnjVurt7NHYkAT1PEhGAnmoAxWR9Su77yWO
 4qEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793657332; x=1794262132;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=04iaPr/Q4xOZpTpewylydaBAPbXSsxNLl37nHemVSI4=;
 b=Pn/1a2DY0a4Wq0YfQepCg+bmqIAz9u4J6n53zFMwpMaxsm+VgsqAjCexOwK1dQBVFo
 PIO+cFK6ZVzMmd+UetrvwSU5gk5hE12qQwwizPJiSHbt1JRvrXPKgoTwlt9NL43xDb2C
 cjh8hbQYNyFXHv4CetKIkZQ3ldij8oR/LvLRO33/QKgMjOfCxG8ZRX/gYVT+sakZuZK3
 E07LFMYY9t4hDyEvJvCJNJ678OHB4xcrvyYj3DoJW8Ysv0LyF/tU6ZC9Sa/oMaD1Ha8O
 dOT2DEBPzDfLKeX3I6hCbDdxITq5mBsX7I4aMN/7nJ2Xme3CDYkMiT/1gNC9+fc7Z5+H
 XWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657332; x=1794262132;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=04iaPr/Q4xOZpTpewylydaBAPbXSsxNLl37nHemVSI4=;
 b=RCmJiqhOkayQCktw7tOszL+cNvXQ1mZM0O4ZpCx9ryz5tPX+5kQKdDHPtNCsSe1qCr
 6z0+XpQ56+ijGY94pkwzz7HbkI6/biXROQEG7UcF8kKz9Td13TcDAYJfd8p+sc+tpsCr
 o7awt1nz5D5avA3WNQLU7P3Aq3i8L0muSrIo1dHPa91xAcWMsOokdmXwQfkpsveOOdtt
 aw3ys9rgkHHTj+N9JXdQLwHkUivQszbRzRzRbfjYL66PWpOeOUfaGYSsv7KFqIMLwuLC
 b9qJfwshVsHdimPAUwgbYifUayv26PuUXfftNPeIEZUBgHCwBJ3VNQTFWAcvHQZ2BkPW
 P0HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSrzMzQvr76LGjSCQg5Eyh4pqy3DxcZAoNVSx8t8wXsohhaGOdjiRNjrYytVVhYqjc5dOpojitkNM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/kI0IjsaWsJTQ66N9vpUG8eROXiGtYL/R0mqRiYC0pM6duLk07
 RpdjQxjHGUzAiqYwqKfUQgJGURIweHmXnaGvGnmXTIefMdVnaJ3rEDNKy5GmtY2xNsXJ2YSF9pA
 gkqGiyX7p6/2ZfuaoFCuurGd4qCbwzea3KXcC9gEK
X-Gm-Gg: AYBFou0+OiMjlhkYvYtVChFqtRFV8VD2KFrmNf3hO4w45IVgOSELM30K0oksN8ILpZ8
 57fzDYzRDagyrSY9HtuBrIGy1jAHEEH8L/KeQWyF/x0Hc/hFxElVb/NnWepE29cqh6dN0UH/Rsy
 0hdkhqYult/oOLEGhGv5b34PvOOAsEUTA/wZjmp+hpttC3oXHfxS0VSYbzYSLGLgmj3U6VGM7fw
 9JdIpL73OI6s9G9twe9Gdr1NXfaALKv37QGXrkj+DBnGeTQqL7t9Ra+14WCcvL6eG26Z2DjQUgA
 zj4wVLMJ/+OxblESXN6CslvIHpkrHpsSZsEa5rs8RnqaF4YLKMS6ADztgSN1wOl5222Efg83hCl
 b9icdwq5JjwaHxB97fCZ/DcGK9PHNRMSVaAoDsQKUjA+jEYiYaRjEWXZNS/2dI8NHXuw=
X-Received: by 2002:a05:6402:438d:b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b53e778d41mr6126a12.14.1793657332128; Mon, 02 Nov 2026
 14:08:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org>
 <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
 <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com>
 <20261102185856.1824792-1-almasrymina@google.com>
 <f4f0fbd6-63e4-42d3-87bf-9f888a8de1a8@redhat.com>
In-Reply-To: <f4f0fbd6-63e4-42d3-87bf-9f888a8de1a8@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 14:08:40 -0800
X-Gm-Features: AclHuK_l2m6u_KEy2pbXoZVvzOwIMj8tI1lJiwLeWg-R9MKJCqxW8rPbMreP4XU
Message-ID: <CAHS8izNQjF6nzPym-kXO2Nr6jv5oKsnFGCNYWZH_zBTGoT98ew@mail.gmail.com>
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, sdf@fomichev.me, 
 kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com, 
 asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com, 
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org, 
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org, 
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 2:01=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 11/2/26 19:58, Mina Almasry wrote:
> > On Mon, Nov 2, 2026 at 7:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 11/2/26 00:16, Mina Almasry wrote:
> >>> On Sun, Nov 1, 2026 at 3:01 PM <netdev-bot+sashiko@kernel.org> wrote:
> >>>>
> >>>> - [High] The dma_dev use-after-free this patch says it fixes can sti=
ll
> >>>>     happen for RX bindings made on a virtual device that leases queu=
es,...
> >>>>
> >>>
> >>> I know about the issues with leased devices. That needs a bit of a
> >>> rework, which I have done locally, and would like to send out as a
> >>> follow up fix.
> >> Will such follow-up rework the code touched by  current patch/series?
> >> how much? I'm under the impression that at least the fix for the issue
> >> reported here would be quite overlapping.
> >>
> >> /P
> >
> > I pushed the follow-up branch on top of v5 here so you can see the exac=
t diff:
> > https://github.com/mina/linux/compare/devmem-teardown-v4...devmem-lease=
-bind-map-dev
> > (commits: https://github.com/mina/linux/commits/devmem-lease-bind-map-d=
ev)
> >
> > There is some overlap (~55 lines of v5 touched across a 6-patch +262/-9=
9
> > follow-up): it renames binding->dev/vdev to binding->map_dev/bind_dev, =
passes
> > the net_device explicitly to net_devmem_lock_dev(), factors out
> > net_devmem_close_rxqs(), and replaces the !rxq->lease / !netif_is_queue=
_leasee()
> > skips in net_devmem_dev_unregister() and mp_dmabuf_devmem_uninstall().
> >
> > I kept it separate only to keep this net fix smaller and easier to revi=
ew,
> > since the lease issue is pre-existing. Happy to either land v5 first an=
d send
> > those 6 patches right after, or fold them into a v6 if you prefer avoid=
ing the
> > churn.
> I hoped for something smaller :)
>
> I definitely would not fold the 2 series.
>
> I'm wondering if this could be considered net-next material? pointing to
> net-next will offer better guarantees for all the work to land in the sam=
e
> release (no need to repost in such a case, I can apply this one to net-ne=
xt
> directly).
>

I'm more than happy with net-next. Honestly so many AI-foudn fixes
requiring so many refactors that net-next makes sense most of the time
now, for me at least. Thank you Paolo!

--=20
Thanks,
Mina

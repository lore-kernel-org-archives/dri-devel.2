Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321A6C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E0210EA9C;
	Wed, 14 Oct 2026 17:41:23 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5349410EA9C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:41:17 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6afac79b3a3so46845a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 10:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791999675; cv=none;
 d=google.com; s=arc-20260327;
 b=IGoJfgUrYjh3K378be2iut/hvzLl4MBeZPm+RRhdn3boaMWbscI3WVoihpVNrze3gg
 K4pbYKtHd/4FkYo8s/vd7E56w6xUua3+zRAhFz8cUvARa7wreljDeKelhcS6WAw6mcKF
 j5/5y/Aw43ZzmPE+KNych0lQv5J2I3Cb2X+IK5hGyzuwFwD0w8xYnytPMklBWlIGeAxI
 enuMkaXNMiReoMhVHsP9QwSl8CRBqzd2bRj4FVSHccajGqNhk2AEI2HLueWKz8v1Gax3
 Llm/L0G4/VDBYUHwhbBNaBpQTXVcNCNqTS+TYYYBV4MWa8CbVZtX9VZxJbE0NIKF4bUt
 Ie6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+j5UmZVaWpFsAwC0ISTNxThhbI3Vq0eD5Q4MhuTUhG0=;
 fh=NeI0j10tSTWoG7KI1S67gmtyYvL0pOzIcwGictsJhNQ=;
 b=YfepjY2Wd4o1qgPlfJuyMPQqQU9QLK44vRl+ta4S6EPJp8Tuoc9j1k23B+59jxTymU
 1A69vd+GqWsH3UiOLYMqOg62STSSLNHS+CmZfRJzL1KOr+0USnDsWY++RickZjVapklo
 py392r3YdI/TWENkFHK3ka8Vwhwf8CZEl7A1JCoL3Q2sibnvZfH1dauOZ07V0DnNKa9T
 xg9e/KIJAmP9SgZoaWIRLRE09+or0Q4k99FIHcWpRyWUDm3i2m7GEaFYSlU9Jdcs6cTw
 czGEDVsZ91ghfZNT63ScsBzkg/wIAREibbIo2A3doeF6ivZtnDPmwsuXPZdyVvg9/qKh
 gV0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791999675; x=1792604475;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+j5UmZVaWpFsAwC0ISTNxThhbI3Vq0eD5Q4MhuTUhG0=;
 b=vsG/bnwO3+9EQv9+0B6c34J8aZiPa5r94NdeMH+kq7gEBWD7XBN8HcbOiRrhdlTAMo
 B8JxSOAHxIyX4/SmsBJWVB1ls4o2kLYMskhRa0HeVLrLDdtUigJMD5PaxTlIrNnEl4DS
 sOXfuE8dfA9M9xw7GmGffTRgvnvhfYNXpEq9XrGWbdfdLIkijQVz0skPHKcRf8JF7Oog
 M73hVF0crMDftDuASqnwHfWwyM00kgAvxG8kxqnzaQ05g7q4hwx/9JRXi7DrvPu3rOAd
 nuLf+yd2Wn40FHwhXwDyijC0t5HcBIYR1IktEgeOY4LbEejqUYXR8cxld/B4iue1d7W6
 vyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791999675; x=1792604475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+j5UmZVaWpFsAwC0ISTNxThhbI3Vq0eD5Q4MhuTUhG0=;
 b=az9uRVry65A4pqd5M0yRQmka5zFky70/Nu/njQBMZka5oW3iVn60Tv3G820GVTkLFf
 NB76T0+MTFnbFHc27lmJY0WUxGSvSIyB9TA7D6VDJes7F+h3OHlBl1zqldu5TvEKP3g1
 aV3qQuHokHoH5RhAyvus9TUtWmTDPKgiM5r2shpUYGQumuByPEj+tO9OWlma9G2nbHWQ
 /1+SJ3/rGe03B7WqDI4Pj0EdHWqNpXCPybtXF+1OZpkQHRRJ0LMmBBv1rV8+YMouD5JQ
 ZAN25kYHTSgZ6Os50n82eBugkbuH1gQ9tgEvRep8bhlevOONI+hy1U388H/aIEIvxG3s
 T7hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQXyIqnq42mRSt64GYTZTpDhhykG4Af1dBDhfDcfyFyt54gklqGe8wXGjCaU65ginQ0nRWcNDjkbc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI5LDJ9Jn1OTkv5QQQdwC9D7pBuY63QUPryLPur+2hs7JAM4qJp
 eUfUvJhOH7jEJQw1cS+z1fOd8yh6KKg+Qhkv85KbJ1Zub1fF/+qkMDQ3ml7J92djNpu9nWv9HqF
 QCtjNlGErRr5sFAWRSXQ7Le6atBU2+YocVPb9ymmi
X-Gm-Gg: AYBFou2lfShqgRCYF1eKZy15R62ShuKzBksJ01EN7YAJM683bbR33d8mbsgRI62r4j1
 VKg9BSTRpJT7u3+Lltp8yQ/oaxnTbSKM7jadM7IeHwY/BUmOj1g/HYO1rDp8HVbQ6bP9reGiU1N
 HtIrkQBIi5SVRDrxDK8NB6zaBOrQ0D26Vyub0Q+vOyiVKb+RN0hffyrK060b0udUyQ0cmllD93i
 bfLDtOAaHv6vwfoGh1wR2zM3koI26MMHEuDOAa6y3cSiXS5PniSys21t8mAb22RkfgRQvzostu0
 g8gLe91Qc7I/XNjmI+TxCla7/5AVgb5UJkS2piSKHX+W4bhtMPi5yg==
X-Received: by 2002:a05:6402:20cc:10b0:6af:97a9:224a with SMTP id
 4fb4d7f45d1cf-6b2096e7803mr65994a12.2.1791999674865; Wed, 14 Oct 2026
 10:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-2-almasrymina@google.com>
 <as-uBvRisS7HxLHJ@devvm7509.cco0.facebook.com>
In-Reply-To: <as-uBvRisS7HxLHJ@devvm7509.cco0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 14 Oct 2026 10:41:03 -0700
X-Gm-Features: AclHuK8u69N7ew0pAEQZHwLPBLn5xdE_tbIzLnNp8gBabvanxWdbaZUh8Vuvjwc
Message-ID: <CAHS8izM9E3YTi19LdNSKY+FWyLtesTAjEmCRHxhgiu=y3t7jaQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
 Pavel Begunkov <asml.silence@gmail.com>, Taehee Yoo <ap420073@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
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

On Wed, Oct 14, 2026 at 9:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 10/12, Mina Almasry wrote:
> > When a bound net_device is unregistered while userspace still holds a
> > netlink or TCP socket reference on a devmem binding,
> > mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
> > netdev_nl_sock_priv_destroy() will not touch the unregistered
> > net_device, but leaves the dma_buf attachment mapped until
> > __net_devmem_dmabuf_binding_free() runs later on socket close.
> >
> > Because dma_buf_attach() does not take a reference on dma_dev, device
> > removal frees dma_dev while the attachment is still mapped. Closing the
> > netlink socket afterwards triggers a slab use-after-free in
> > dma_unmap_sg_attrs():
> >
> >   BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
> >   Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
> >   Workqueue: events __net_devmem_dmabuf_binding_free
> >   Call Trace:
> >    dma_unmap_sg_attrs+0x76/0x2b0
> >    unmap_udmabuf+0x8e/0x100
> >    dma_buf_unmap_attachment+0x145/0x330
> >    dma_buf_unmap_attachment_unlocked+0x96/0x130
> >    __net_devmem_dmabuf_binding_free+0x156/0x2e0
> >   Freed by task 9:
> >    kfree+0x1b8/0x550
> >    nsim_bus_dev_release+0xe/0x60
> >    device_release+0xcf/0x250
> >
> > Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
> > and null out binding->sgt and binding->attachment after unmapping so
> > unmapping is idempotent across queue uninstall and deferred binding
> > destruction. Call it synchronously when the last bound RX queue is
> > uninstalled in mp_dmabuf_devmem_uninstall(), except when a leased
> > queue is unleased: the physical device is still registered and, if
> > restarting its queue failed, may still be using the binding.
> >
> > The same use-after-free happens when the netlink socket is closed
> > before the device is removed but RX tokens or the pending release work
> > keep the binding alive. Such bindings are no longer installed on any
> > queue and were already erased from net_devmem_dmabuf_bindings. Keep
> > bindings in net_devmem_dmabuf_bindings until they are freed, hide
> > unbound ones from TX lookups with an xarray mark, and on
> > NETDEV_UNREGISTER clear binding->dev of unbound RX bindings for the
> > device and unmap them, unless the device is a virtual device leasing
>
> [..]
>
> > queues, for the same reason as above. net_devmem_lock serializes that
> > walk with the final free.
>
> Can you explain net_devmem_lock a bit more? In
> net_devmem_dev_unregister, why can you not net_devmem_lookup_dmabuf and
> then rely on the binding->lock? The rest looks good, but the
> new lock seems a bit excessive?

That problem that my feeble human brain can barely understand is that,
in order to revoke bindings when devices go away, we need to hold the
device somewhere. I decided the a good design would be to keep them in
the xarray but mark them as unalive; that seems nice.

Now xa_erase the binding got moved from unbind time to free time,
which makes sense, but that generates this pathological race, where
net_devmem_lookup_dmabuf for unregister can actually find a binding
for which the last ref has been dropped, but _binding_free() was not
called yet. Fun. I tried to work with the LLM to find another simpler
approach that gets around that but no luck, the overlords find a race
with every suggestion; this seems like the simplest thing to do,
although it is depressing to add yet another lock.

I uploaded v3 btw to address the 1 non-lease devices issue. Seems
we've crossed paths again, let me know what you think and I can spin
V4.

--=20
Thanks,
Mina

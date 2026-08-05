Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAE0C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A26610E175;
	Wed,  5 Aug 2026 06:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hZFLiu3U";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48C110E175
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785910112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
 b=hZFLiu3UwUoW2CwdY6gEUvQDxXKoHngko7VL2leRakgVyhEHNySZZVGhEE3N85C9iKFZtE
 SR9Xm6562dgTI6qF/wnLs+3EMkGa5lzbkFlQwNZPNsBXioSXpQIdxeRfedTBj5Lx0E0Qqr
 h+mFlBMv4c+GA3DKqa1wBOQ5iaFmzb8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-wG0B5mlVOuyQf8FpmZtO7A-1; Wed, 05 Aug 2026 02:08:31 -0400
X-MC-Unique: wG0B5mlVOuyQf8FpmZtO7A-1
X-Mimecast-MFC-AGG-ID: wG0B5mlVOuyQf8FpmZtO7A_1785910110
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so303827f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 23:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785910110; x=1786514910;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
 b=ndDUbFt6XjWhQ8CWZRaYiNSaG/dqz2xS2BslvtPeoJzoDRNrRzHZkanWVGnr8trZC5
 /21F6aLJDh884ZfOhDLVmbyl1s3q5F8rUQKi4tb15Tk5FZ3mFc1IfobsVLiG1bd+K12p
 hy/HQYEba2oVy/9C349zHWkhPYJgOFFOTlMXDgkaBdpDMy0OMNsJ7zmaWP0LXtCS0kut
 snU2yixC85G94ktaxh0Y6yly1qRBsenADetyYf4/OJvjYMKwWrovur73jG4xWYCUwRbc
 jB7EfwLOe7E7ICNWfFFYkwAAg/UPl8KOfOQNbeiFT1SYiSWJ976j3JaK/ItG2Xy8USo5
 iuIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3t1hvcse34t0SQ+kLjbBlBXCL5MUxF54mth55FpbT1hED+7m5gPUNjwRaK9VpsXqnJnbNX0I4NRo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoPn0O3c8Om+dexxf2qeMK75RVoBRntv5lpszhy2wNz1e5ZTbv
 HwA+704yjk2owb6Ub7CfX2edzM4nYwvUODmakYQi1Gvg94IiqGJuLKCO+MwNT1uj09ReWSACP9M
 uABCt2Asu7cwPyXTwXjKoeA6Lnj+SyxgYwhBeuBxElprGY4rV3i8/dyXsE8gjgdBaS/t+l7CrTk
 4erAkuXKRLsjD8uCE/Ol/ClRgpBwoDWvPYEnJoCIyyRJDM
X-Gm-Gg: AR+sD13Fcbmn2v7N6kKStEKFrbWmle3RzgRZn8/IKZEE+rK9CJ4KLrjL5uJg382ia9V
 tWkXy6h/mnYDs1aA0skpGpcmNfsG5o7rclRidksc75xNenQBmsMj2GAb5j+v5ZNqpIN9YT/2SeI
 kLxfDC8fIgXq2FG7XAVGcLmV3i8Viemfz7DPJx4hH9dJ3XC/c846bo2F/DZ9poXvUHaTLEcib/R
 2ex03YrnaafrBnP6pYa0d1A0/PXmD28hDeC6CyctdWPkAZXP/8L+x/xI0c=
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id
 ffacd0b85a97d-47fec4e888cmr5402596f8f.6.1785910109885; 
 Tue, 04 Aug 2026 23:08:29 -0700 (PDT)
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id
 ffacd0b85a97d-47fec4e888cmr5402532f8f.6.1785910109519; Tue, 04 Aug 2026
 23:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home>
 <20260804161850.58c55c6e@fedora-21.home>
 <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
 <20260804164206.655874ce@fedora-21.home>
In-Reply-To: <20260804164206.655874ce@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 5 Aug 2026 08:08:17 +0200
X-Gm-Features: AUfX_mzo9t9ubVXz5xpYzVx4R9t4U8bdls__QKfQW65v6eCkMtC4FUkJ5hgXDI8
Message-ID: <CABgObfY67mdG9QZ5__Q9GDrEq9Wutc42_tHo8YGSMOPnruZmsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
 Christian Koenig <christian.koenig@amd.com>,
 David Hildenbrand <david@kernel.org>, 
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
 Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vBUP1-Mtq_HCO3TeyhxcyL2i6IBJqWyVWGLTqwdttac_1785910110
X-Mimecast-Originator: redhat.com
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

On Tue, Aug 4, 2026 at 4:42=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> Okay, I thought I'd ask to be sure, because of all the implementations
> of pfn_mkwrite listed here [1], only drm_gem_shmem_helper.c and
> kernel/events/core.c do that.

Also the vmwgfx one in patch 3; and for the !DAX case ext4 and XFS too
(e.g. xfs_filemap_pfn_mkwrite gets to iomap_page_mkwrite, not to
filemap_fault).

> The rest have their "generic" fault
> handler (by generic I mean a fault handler helper that covers all the
> order/WRITE_FLAG combinations) called from pfn_mkwrite(), and return a
> non-zero vm_fault_t.

I see; I think you can do that, it is handled at
https://elixir.bootlin.com/linux/v7.2-rc5/source/mm/memory.c#L2681 and
indeed it returns VM_FAULT_NOPAGE. But it's more or work for no real
reason. Your .pfn_mkwrite is a single line of code and it is clearer
IMO if you can see that try_insert_pfn() is calling the same helper as
.pfn_mkwrite().

Paolo


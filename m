Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F806C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953EA10F25A;
	Thu, 13 Aug 2026 09:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CjXM58ID";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691E210E367
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:49:46 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-6688acd1a51so2896752d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786603785; cv=none;
 d=google.com; s=arc-20260327;
 b=nNtTIBgurlA6xBp72vKelwGjHfaeGoij3FedKUTvt0zZe9oQD5Sr81ZxHE4O1n+Zz4
 J+EJBQYNFyzXU5yTblnJoSt7NnecJSdlrnxc3XyiB5mbuWHrK7ZzxRVn/cOp2eqVh3n1
 uQ2PvrFRlnE5m2DPZvFqNqdjLPaK9xLPq1vrOSzafksSauBJqS0EvI4sba6LdbiDNqM6
 prpRTQAnJxdd8lhkSpUnlEs699WHN+y3zn15fNE1g02nLz9sTgAiWC5vOkKvK1S73BQ3
 a6sWC+LbKd3VnqdE9JPiJx7VoL0hbDoy8BsCR7AkO3YCHUtsdox3VyYwAjfOJmU5rzj4
 xRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ekGdW2eYO2lOIBBZgTx2MF8tFA1VXLBcZFAQ3KWc9e4=;
 fh=jqefEpgve/HYCr3HIsbqLFqRItU/lx4qM2OzYfE/nZU=;
 b=NfvsQevc21x40qQs9XN7ynplxu44x5qyq07af7BdRYIATyfO3souSan32IsrVuTLSz
 ZavdFICNUZix5PWy9b2SdTRtv9DiH+LT6DLHyVBsyCzHtakQ7aEvpBwMu6oq54zq7tS2
 ICcQCIFOtxm09NYytCrb7bHmHyxW5TgOpyllUQgZCAGvPf4UBm5UwYLnz8nyRqoYBMeF
 r7LNg8zmuBx0HvEVEEgfjpDgC8vL7d+9cgvlH9R9ZTD50lgelKdAkfLyrzXTBgndggnX
 5h5G3bNaJ5dyNAadL08sqRQy9ZpNNbqlb6osNURUgVUDCALXMbMMJWzGfBb7TTSmEhuK
 iAkw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786603785; x=1787208585; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ekGdW2eYO2lOIBBZgTx2MF8tFA1VXLBcZFAQ3KWc9e4=;
 b=CjXM58ID4daF0rMFMS/eAGcPGfxEKzZi9uKWVw57UYwwNtJgJ0tAmPriTv2tSREo9l
 r7yE323JpCOo/o85liAm5WC91tlaHjGHJYmsYqy2Bthv459Y+2NgoZR3lMvae3T8csZR
 FWo0vrO+E0HI/4AzG1hdf2c0SJdxlrKiVg2T9L9ElrzXmUjNkHjZAfbv8gibB6dm15PK
 1Cw8Y2Ihonpyey+atfh95nCruedah3FRQI4/FZNlzZS6rbjBD/thlezrWzxgHJyEt3b7
 GSd4GILwut6XLb2/WIFexmH7SWeckIUKLBoo3ZfOtcRxDRyQt4uRtJmepIFvkDRfb+sf
 4wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603785; x=1787208585;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekGdW2eYO2lOIBBZgTx2MF8tFA1VXLBcZFAQ3KWc9e4=;
 b=lgyrsclSP+mQmMIMXG2wkAOOLgJosE7MtLzUcgzm/O12U5frAIA6nB5idf1y2EXewM
 IxUcTqLtJzhEeDnHmalHxpXM+2d4pUo6HO12YYLi8unUOmVxSj74hqfP5Lb3MUO267cB
 PhsIbN9yEckHaLUBz3oCHRKOvt1KXMdIaCnztmVvoQG+BMAbBxpduSZ1EVX/yE+QoJi1
 cWH8q4INVbKCy72Ktfynvc0e+JGx5bOqNXoAgidl09D9/crWmqmXA1Wt6hwHRrrhLlji
 vW9hReBdm8gyGHxfTFuN4mdA1gJRWS4AFywJt7YKXnjjxWET0mgskNZvbPQ9+VQRpHJ0
 MpJw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3i5a+FLQL7WOZancqPmpM8rZj3bD3Cb4nYFgL+0eWRlUeLo/IxeNfrKncfztgpVLI6+DAkVqrDfE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4EBsWDYG2REyQf34U6H3yL5QsSxZjVKZ5bmePE722YXUwjZbj
 nhqAnlIldD9YmbYXkNtTh6hoKgYzIuPwjC7GiJ1uJBxjpvmsbN3LgWD442DAvSLrRyldqlauHn5
 +zn+RllsiI1Uu2p26Ebim04OROu/CZQc=
X-Gm-Gg: AR+sD117weMswUwT2V34qejnUtVzfs9C6lPl6e5ofATp/0zVOxkQDx39t5QwZMSzuQF
 rauTYtGqzc4Zi5sBT7Tbwyl+iu089wUhGxkwzhidfXPJG+9MM9kv84Iaw3ywQuAm0YW0ytZQ+zt
 FDWAGun3GkyWgaR5YcnQo15yR6cnl5bYxz3oJozu0gc5lGRqjsb/dPjefgl21UJKw5IIKFPktDk
 OBjYwaOqpAXTlQnky5SUUmySzmHqkMV+8w1NPBNGovmANYyAqtsW/GCM4516FGmKteihB0Dycsh
 q/4DiHVtiPMokV7FunwEdjxPiECZ6dFwPQ02whCvAJLkrPFxv2SVEaf+L/m7ZFACZ1PNNJ4ZwuO
 FObyJjPNLfVYJQFY/FJLRHG9ekI4FML3U10OVnQ2IMqfo
X-Received: by 2002:a05:690e:583:b0:669:9498:3018 with SMTP id
 956f58d0204a3-66c517922fcmr1279824d50.36.1786603784947; Wed, 12 Aug 2026
 23:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260809090430.20577-1-kartikey406@gmail.com>
 <w3p7i7btvl6b7o5puofyxcjm362ni3mtcfmog2plm6h5wxk3an@dflvwud5t6zf>
 <cf0f4111c04ec71ae979b71c95fa1158c5e68a8a@intel.com>
In-Reply-To: <cf0f4111c04ec71ae979b71c95fa1158c5e68a8a@intel.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 13 Aug 2026 12:19:32 +0530
X-Gm-Features: AUfX_mxP6t7tFSfCkk-uHSOc2JdwpZ9HW9cJpOkY0Z8jfMuurlxTQAVf2aDT8NI
Message-ID: <CADhLXY4wnwAi5mL71s5XSEoqdKF=vDOHmO0uL_=mhdS+Zk4uOA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, 
 simona@ffwll.ch, chris@chris-wilson.co.uk, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

On Tue, Aug 11, 2026 at 3:01=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Tue, 11 Aug 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> > Hi Deepanshu,
> >
> > On 2026-08-09 at 14:34:30 +0530, Deepanshu Kartikey wrote:
> >> pci_match_device() can return the dummy pci_device_id_any entry
> >> when a device is force-bound via sysfs driver_override, in which
> >> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
> >> struct intel_device_info * unconditionally and dereferences
> >> intel_info->require_force_probe, causing a NULL-ptr-deref.
> >>
> >> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3Ddb96c5ff032f4292a8dc
> >> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> >> Fixes: 42f5551d2769 ("drm/i915: Split out the PCI driver interface to =
i915_pci.c")
> > This "Fixes" tag should point to the commit that breaks stuff,
>
> In general, agreed...
>
> > I believe, so what you are looking for is
> > 7ef5ef5cdead ("drm/i915: add force_probe module parameter to replace al=
pha_support")
> > since this patch introduced that unconditional dereference.
>
> ...but that didn't introduce the unconditional reference. I think it was
> always there. We've always expected .driver_data to point at whatever we
> have specified in MODULE_DEVICE_TABLE().
>
> I'd just slap a Cc: stable on it without Fixes.
>
>
> BR,
> Jani.
>
> >
> >> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> >> ---
> >>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i9=
15_pci.c
> >> index 82415af47d54..2f03f95945f1 100644
> >> --- a/drivers/gpu/drm/i915/i915_pci.c
> >> +++ b/drivers/gpu/drm/i915/i915_pci.c
> >> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >>              (struct intel_device_info *) ent->driver_data;
> >>      int err;
> >>
> >> +    if (!intel_info)
> >> +            return -ENODEV;
> >> +
> >>      if (intel_info->require_force_probe && !id_forced(pdev->device)) =
{
> >>              dev_info(&pdev->dev,
> >>                       "Your graphics device %04x is not properly suppo=
rted by i915 in this\n"
> >> --
> >> 2.43.0
> >>
>
> --
> Jani Nikula, Intel

Thanks for the review. I have sent patch v2.

Deepanshu

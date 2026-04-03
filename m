Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F83E8536F
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B295F10F1CA;
	Fri,  3 Apr 2026 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RpU20yg3";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BA910F1CA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 15:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775228487; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dWoaM2irJk5jpOAtQrluaGQys4xY60H+PLCJiiT4wpV4MrxdtOLPO2E/F6/XN4afoVEVWWehlz+KVTpoT8PZTJLmb0hojDcaHsyJ9Guq4nVLFXasGtV14RGuJ6r4ixoGH1piVOEep8nuegOekx8NlLkRr87n/GEUs9rDLJeyWH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775228487;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=akV+WEPGSMSaA44z7ljDrx3VWcqrFrqZr4HffcZjsbQ=; 
 b=fRkDSMwDcmHfX2UqjYOYfWHefOp/jWC6TcdE8tKBW4oYSlr4LjRr3tnMZoGUJoGQVJbdcp1ayBH0tpUB6Gl108OPgpKJMvs9JNKf4cwffXGJtbD/mfufWpwjvkxFr8POlK8WVFNnboZBfUI0S5GfV2P7qwY+vU1mnhxNU+SbxOE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775228487; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=akV+WEPGSMSaA44z7ljDrx3VWcqrFrqZr4HffcZjsbQ=;
 b=RpU20yg3av+j7Eq3SiNE6faATH0oQDgAd+Ge7n00dtSoI8HmmJZ/DNcIV+Zwb//X
 k3gSJswWFDv0G8+cY8hZDd65q21xXVxLyHsOOc+LKqWpACpElCRVl/flgyduNtshqn6
 1SFY9H+Mkoehy08iDYj+OHyx/44Vi5+xggVwxcog=
Received: by mx.zohomail.com with SMTPS id 1775228484668460.5452292997252;
 Fri, 3 Apr 2026 08:01:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260319120828.52736966@fedora>
Date: Fri, 3 Apr 2026 12:01:09 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9876893D-F3B4-4CA4-8858-473B6FB8E7EB@collabora.com>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev> <20260319120828.52736966@fedora>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 19 Mar 2026, at 08:08, Boris Brezillon =
<boris.brezillon@collabora.com> wrote:
>=20
> On Fri, 13 Mar 2026 12:16:44 +0300
> Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
>> +impl Controller {
>> +    /// Creates a [`Controller`] instance.
>> +    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) =
-> Result<Arc<Self>> {
>> +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", =
0)?;
>> +
>> +        Arc::pin_init(
>> +            try_pin_init!(Self {
>> +                pdev,
>> +                iomem,
>> +                pending: Atomic::new(false),
>> +                wq,
>> +                work <- kernel::new_work!("tyr::reset"),
>> +            }),
>> +            GFP_KERNEL,
>> +        )
>> +    }
>> +
>> +    /// Processes one scheduled reset request.
>> +    ///
>> +    /// Panthor reference:
>> +    /// - =
drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
>> +    fn reset_work(self: &Arc<Self>) {
>> +        dev_info!(self.pdev.as_ref(), "GPU reset work is =
started.\n");
>> +
>> +        // SAFETY: `Controller` is part of driver-private data and =
only exists
>> +        // while the platform device is bound.
>> +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };
>> +        if let Err(e) =3D run_reset(pdev, &self.iomem) {
>> +            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\n", =
e);
>> +        } else {
>> +            dev_info!(self.pdev.as_ref(), "GPU reset work is =
done.\n");
>> +        }
>=20
> Unfortunately, the reset operation is not as simple as instructing the
> GPU to reset, it's a complex synchronization process where you need to
> try to gracefully put various components on hold before you reset, and
> then resume those after the reset is effective. Of course, with what =
we
> currently have in-tree, there's not much to suspend/resume, but I =
think
> I'd prefer to design the thing so we can progressively add more
> components without changing the reset logic too much.
>=20
> I would probably start with a Resettable trait that has the
> {pre,post}_reset() methods that exist in Panthor.
>=20
> The other thing we need is a way for those components to know when a
> reset is about to happen so they can postpone some actions they were
> planning in order to not further delay the reset, or end up with
> actions that fail because the HW is already unusable. Not too sure how
> we want to handle that though. Panthor is currently sprinkled with
> panthor_device_reset_is_pending() calls in key places, but that's =
still
> very manual, maybe we can automate that a bit more in Tyr, dunno.
>=20


We could have an enum where one of the variants is Resetting, and the =
other one
gives access to whatever state is not accessible while resets are in =
progress.

Something like

pub enum TyrData {
  Active(ActiveTyrData),
  ResetInProgress(ActiveTyrData)
}

fn access() -> Option<&ActiveTyrData> {
  =E2=80=A6 // if the =E2=80=9CResetInProgress=E2=80=9D variant is =
active, return None
}


>> +
>> +        self.pending.store(false, Release);
>> +    }
>> +}


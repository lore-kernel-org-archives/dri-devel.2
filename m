Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4157CC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D99F10E439;
	Mon, 17 Aug 2026 18:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="S3tudvW/";
	dkim-atps=neutral
Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE11F10E2AF
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 18:22:12 +0000 (UTC)
Received: by mail-qk2-f9.google.com with SMTP id
 d75a77b69052e-52838fe2172so8428791cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1786990932; x=1787595732;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cy7EcQJSpnXZMIEn2xYEeGMt8Vb7G/dRmaRGic/8Zt4=;
 b=S3tudvW/xLI3Jo8AtdqrlkE2eIIsUCFGkThc/TLby42CgzhEETFkzANHV5irRDRcS9
 5xXYFVAyNwUmtNqFb3q4yQ8w0ewYkgizI+3HJhTlPIW34zccBkrSQk8+fBLusE2wtFJU
 dob07zBJ5SUI/a+OBIi//B+l7Q2du3bgZxDXQnhoCh2nkgJrXfGRVS6vF3k+Q9M3QJyJ
 zmHtgmPB/WDJRH2KE+/PGeijyom/7XQVCHGFQITnQQ8iHFx+1H5hLwqZ9DgNKG54bAOv
 NudUhRqBT5Jz+TKHGLQwR9eSNx9Np0xgMCE2XaFh7F2hndg9o4Qya0CQ7o+HbfZX8JZf
 lMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786990932; x=1787595732;
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cy7EcQJSpnXZMIEn2xYEeGMt8Vb7G/dRmaRGic/8Zt4=;
 b=Rnz8ZAAl+EUk6p1Hl0OmziYnNa4SIXApGnEAfZirUK5vsjgqZ6T1llqE9UmlR0SWaz
 XXrg5GpMsJ99EebLFhXficS/WphwhnxRVCY4/y0OLtjPCajNBp7vyLQRkiQu1oE7/m9S
 NDdFVYT6Y62kdY9akrCJxm+C7AqKcAffffD3BdyZuTe9yvUS7vyGhDFLimj1Hftj15KX
 9W06N4xYOjsFAxs0QZrJEZAntli5zOiAtBnYdPslps0Ymt3Go5gsuU8uet0qJRkVOnhA
 8bvTXNUaFOfkdZAI9pP5Ga+LcANBt2FF8CYT+1//b8zK7fyHfN1yuYiO57tUr5PUyeI/
 ofzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkbuONKr0T0dqtVbC6pbKrlM1qoPaW0r1LBan5XRTZ4JFuL7kn/c1WSObTXQlaiIPG2CL/7cvt0is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC5s9qQDj/QXm5UzHCZJDob0MectmeO7c504oX/WuoMT7+RX5S
 mCCkR5qvmCWu/JhuH9mjo8cSn7q82ygA9Kpir93yPuWuWgPPFv6dDysaKziQ2VDAVa4=
X-Gm-Gg: AR+sD11z3EWereVUb7aZLUBN1Zepd1sjv237KEhaGsNbYrarUf7XBGSeBJpB4oZSiAh
 OQePGtVmeDXM5UvP9gBMYdsAjnDo2R/Ce3V8LfFG8I9hJM8NXOuOcb8Tx71nWBScXuIcYf+zDl6
 JBovon29uwrLrJKK2aDcNHq3w8yVLhi8wo6rgboQaS4ClxtAoAF/hFqGT/6JCud7zzcJ2cr65KR
 nB2ll42+FhVNupVbAfBPXBgF9b61j9StBXZaYysZLmUwL6b7Wr99ALFua+TGO9itFiG8OnpOlb8
 rlEwbIiT1aDHTrjNAao+NYtTrUKuNUln0vsoKqwg017mRcDR5Rz3/X6DA8W5bjzO0IGC3PMMJTb
 L1ly5JJiQx4gWbrPxjpsB+TNDx1pL+V6n5hyU+atsCIGZvC5VYfT2GgwU08dwWvmu0gYOOKP4hB
 NrrSSm/nEvgwyInlz6MWZQIDdh5phE3kGdbMIoQ7Ve1k22r2ws2eNvFkkOZZ6AqLgi
X-Received: by 2002:ac8:5d14:0:b0:52d:a4e5:6b3c with SMTP id
 d75a77b69052e-52dbd638fedmr30677991cf.15.1786990931320; 
 Mon, 17 Aug 2026 11:22:11 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e221::c41? ([2606:6d00:15:e221::c41])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm20543191cf.12.2026.08.17.11.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:22:10 -0700 (PDT)
Message-ID: <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Igor Paunovic <royalnet026@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Heiko Stuebner <heiko@sntech.de>, Jiaxing Hu <gahing@gahingwoo.com>, 
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Date: Mon, 17 Aug 2026 14:22:08 -0400
In-Reply-To: <20260801131656.58450-1-royalnet026@gmail.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-Uj4DXSO5nfw2UYdvSayp"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
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


--=-Uj4DXSO5nfw2UYdvSayp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

Le samedi 01 ao=C3=BBt 2026 =C3=A0 15:16 +0200, Igor Paunovic a =C3=A9crit=
=C2=A0:
> Hi Tomeu,
>=20
> Since you asked for fixes to be sent upfront I have kept poking at the
> RK3588 NPU, and I ended up implementing devfreq for rocket locally.  It
> works, but on the way there I hit a crash class that I could not find
> documented anywhere, and I also measured something about the vendor OPP
> table that I did not expect.  Both seem worth sharing before I clean any
> of it up for posting, so I would rather ask first than send a series you
> may not want in this shape.
>=20
> Cc'ing Jiaxing since he is working on the clocks and on RK3576.

Tomeu just notified me that you had sent this RFC. Without any precise
commitment, I was also interested in this and have used AI to come up with =
a
proof of concept. I'm only looking at the RK3588, I suppose all the issues =
below
related to RK3576 ? The main constraints on RK3588 is that there is one clo=
ck
rate for all cores. the PM part allow suspending the cores independently, b=
ut a
special case is needed once all core are suspended, since you cannot resume
reliable at any other rate then 200MHz. This part still feels like a hack t=
o me,
I might just hand rewrite it once I have a plan.

https://gitlab.collabora.com/nicolas/linux/-/commits/rock5b-npu-poc-4?ref_t=
ype=3Dheads

I have saved my work here, even though its far from ready to be sent to an =
ML.
You will feel the AI vibe in the comment/commit, this all needs to be rewri=
tten
for human readers. All this work depends on upstream ATF, I have no idea if=
 the
ABI is the same as downstream, and to be honest, I'm not very interested in
that.

Please, feel free to take whatever you like, I'm still working on it, but i=
ts
possible my timeline will endup too long for you. Some important note:

**operating-points-v2**

My view of it is that its not that useful for devfreq in general, you mostl=
y
want a max/lower rate effect, since throughput is generally more important.=
 But:

1. I was adding it anyway with the idea that a future thermal (which you re=
port
having) would be able to throttle it in small increment. As you reported, t=
he
chip itself does not seem to heat up, but my view is that if you can balanc=
e the
throttle across CPU/GPU and NPU, you may be able to sustain better overall
performance (to be proven).

2. Even though we always hit max rate, having the OPP makes it really easy =
for
someone with low power constraints change it per board.

The other problem of the OPP implementation is the driver and DTS side. The
bindings seems sane, we don't require it for backward compatibility reason,=
 but
the driver is modified in a way that it will fail if you don't provide it. =
I
think it would be fixed, and driver should keep working without the OPP in =
the
DTS. In the DTS, I've removed the assigned clock/freq, to me keeping it wou=
ld be
toward forward compatibility, and is fine, but I don't always fully grasp a=
ll
the subtil trap of DT compatibility. Its something I will want to ask an ex=
pert
before hitting the ML.

cheers,
Nicolas

>=20
>=20
> 1. The hardware constraint
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> An NPU power domain cannot be switched on or off while the NPU compute
> clock is above its DT assigned-clock-rate of 200 MHz.
>=20
> Changing the rate while a domain is already on is fine - I have taken it
> to 1 GHz and back many times without a single error.  It is the domain
> transition that breaks.
>=20
> What happens when a domain is moved at a high rate:
>=20
>   rockchip-pm-domain ...: failed to get ack on domain 'nputop', val=3D0xa=
9ffe
>   rocket fdab0000.npu: devfreq: cannot power up for rate change: -110
>=20
> The domain is then wedged: genpd still believes it is on, but the first
> MMIO into it raises an asynchronous SError and the box panics.  Captured
> over the serial console:
>=20
>   Kernel panic - not syncing: Asynchronous SError Interrupt
>   Comm: rmmod
>    _regmap_read
>    regmap_read
>    rockchip_pd_power
>    rockchip_pd_power_off
>    _genpd_power_off        <- rollback
>    genpd_power_off
>    genpd_power_on          <- failed
>    genpd_runtime_resume
>    device_release_driver
>=20
> This is not specific to nputop.  I have the same message for 'npu2'
> (val=3D0xa9fff), which matches the DT: all three NPU domains list the NPU
> clock among their handshake clocks - rk3588-base.dtsi lines 864, 877 and
> 885, for RK3588_PD_NPUTOP, RK3588_PD_NPU1 and RK3588_PD_NPU2.
>=20
> So the clock the domains need for their idle/ack handshake is the same
> clock we would be scaling.  My best explanation is that the PLL that
> produces it lives inside the domain, so once the domain drops, the clock
> state goes with it and the handshake can never complete.  I cannot
> confirm that part - reading the PVTPLL registers is documented as
> hanging the machine, so I have not tried.  The behaviour itself is
> reproducible and cost me four hard hangs before I understood it.
>=20
> I mention it because it is a trap for anyone adding DVFS here, including
> the RK3576 work, and because it is invisible until the first time you
> let the NPU idle at a raised clock.
>=20
>=20
> 2. What ended up working
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Runtime PM callbacks are not enough.  The domains are powered on by the
> driver core before probe, powered off from a workqueue after detach, and
> system sleep bypasses runtime PM references entirely - so the driver
> never sees all the transitions.
>=20
> What does work is hooking the transitions themselves:
> dev_pm_genpd_add_notifier() on all three cores, and on GENPD_NOTIFY_PRE_O=
N
> and GENPD_NOTIFY_PRE_OFF force the clock back to the DT rate, vetoing the
> transition with notifier_from_errno() if that fails.  Every path -
> runtime PM, system sleep, attach at probe, detach after unbind - goes
> through _genpd_power_on()/_genpd_power_off(), so nothing can slip past.
> If a transition does happen, the boost cancels itself and says so,
> rather than leaving the driver claiming a rate the hardware is not
> running.
>=20
> This has now survived everything that used to kill the box, including
> repeated sleep/wake cycles at a raised clock and rmmod while boosted.
>=20
>=20
> 3. The numbers, which are the surprising part
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Measured with MobileNetV1 through Teflon, one inference thread pinned to
> one A76, and a bit-exact oracle: sha256 over intermediate tensors on
> every iteration, zero tolerance.  The 600, 900 and 1000 MHz rows are
> 30-minute runs of 275k-280k inferences each and the oracle passed
> bit-exact in all three, so none of this is instability; the 200 MHz row
> is a shorter control from the same session.
>=20
>   nominal    supply    throughput
>   200 MHz    800 mV     68.5 inf/s      (the current fixed rate)
>   600 MHz    800 mV    155.4 inf/s
>   900 MHz    850 mV    152.4 inf/s
>   1000 MHz   850 mV    152.9 inf/s
>=20
> 600 MHz is the optimum.  900 and 1000 are indistinguishable from each
> other and both land about 4% below 600, on a quieter and cooler machine.
> The vendor OPP table decoded from the downstream DTB asks for 700 mV up
> to 700 MHz, 750 mV at 800, 800 mV at 900 and 850 mV at 1000, and I ran
> the top of that range at the voltage it asks for - it does not help.
>=20
> Backing out an effective clock from the per-chunk time, nominal 600
> appears to deliver more than nominal 900 or 1000 do.  I would not lean
> on that decode, but the throughput ordering does not depend on it.
>=20
> Thermals were never a factor: the highest I saw all day was 50.8 degC,
> against a critical trip at 115.  This is one board and one model, and
> MobileNetV1 is memory-heavy, so a compute-dense network may well behave
> differently - but for this workload the top half of the vendor table
> buys nothing.
>=20
> If that holds up elsewhere, an OPP table for rocket probably should not
> simply mirror the vendor one.
>=20
>=20
> 4. Thermal, separately
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> While looking at this I noticed npu-thermal has only a critical trip at
> 115 degC - no passive trip, no cooling map, polling-delay-passive is 0 -
> while gpu-thermal, a few lines above in the same file and on the same
> tsadc, has both.  That was harmless while the NPU was pinned at 200 MHz
> because it could not be slowed down anyway; with DVFS it stops being
> harmless.
>=20
> I have two small patches for that (a #cooling-cells binding update and
> the thermal zone itself), but they only make sense once something
> registers a cooling device, so they would belong with the driver work
> rather than on their own.
>=20
>=20
> 5. What I am asking
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> - Is DVFS for rocket something you want upstream at all, or is it better
>   left alone for now?
>=20
> - Does the genpd-notifier approach look right to you, or is there a
>   cleaner hook I have missed?
>=20
> - Given the measurements, would you want the OPP table to stop at
>   600 MHz rather than follow the vendor range?
>=20
> - If you do want a series, I will need to clean the code up first - it
>   still keeps its state file-static rather than in rocket_device, and it
>   bypasses the OPP layer for the rate change because our own direct
>   writes leave the OPP cache stale.  Both are fixable; I would rather
>   know the shape you want before rewriting.
>=20
> Happy to send the current code as-is off-list if that is easier to
> comment on than prose.
>=20
> Thanks,
> Igor

--=-Uj4DXSO5nfw2UYdvSayp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaoNRUAAKCRDZQZRRKWBy
9HZgAQDrkxvYskLAw8gEIVI2Q4ae04HdIWafP+WTfZPgHyu4nwEAzUKPjLWWOT8+
QI/lXNLGXy4kPVK1pFCd2Vnic1mtlgg=
=h+ql
-----END PGP SIGNATURE-----

--=-Uj4DXSO5nfw2UYdvSayp--

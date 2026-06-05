Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4CBCD8C93
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3BA112D61;
	Sat,  6 Jun 2026 07:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qAv89s9o";
	dkim-atps=neutral
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DD511A6D3
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:04:58 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7C4903F5B1
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780653896;
 bh=9VSfaSmZiuzc3OUajzl27LDOjRPp4i7hhVD2ZvkIMkg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=qAv89s9os4fVthX4wJq/OgD2JPaRYazhLRDVuf4DuHBgAH+0873dxpZMVatEJCgAU
 T/pafUpQUpVD2h9vs+dktOJz+ezcjtE2cPcz64P3T/Z+iGhuTbzeJbdb3fwMlW2SHI
 /2WB//y/ERg1MT8ZQc1yOPUBgDrZnYvON40VewvYmu12dO0tBBVxMUzROHWgEhtRl1
 vfddxH3/zs03UhrBvVeOyMNUxJaVB2CCEVrbT0Ma6n6bvyhbJzR6QEq7P+cfVeaMCx
 lKdBSPf9rqAG5/eiGAhBgS+JndSw6PY/wtWwENUkgo/wVhMyV+Nna9clcPCGf0lM7V
 T5I0Z/atFeLMV9uD4VhHH8arq0d4T6uTgXZoqbP22BAKAwNwdMH3Mc4MIypuorkCnK
 bKncvDss2Q6FWW99pQCTfaf2SNDhKzQR1NzDLrPHbQ5cGHZe7QB8cOsRN1dl4n3GYn
 jxU2SEHJ+g0A5kXzKy2DvFT2R/U5GPryoKbTbu5ddnPLuUqkhdV32QntGMwxcge/G1
 N7scUbtEOS/8818bN5Bmi8Mx4qwMlpF06mjlHNqJBKty2FidmLblC6kO1exLNGvIYR
 BQAvnkXfdtetfOBVI2kAw/Ou2glZxjpXwL1Tet5j7xrMMYJYfFvl7LuOodPqK5tEFR
 A+DkBJU0J6bQTx7RP3hz+sjg=
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e5fb37ac4bso348401a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 03:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780653895; cv=none;
 d=google.com; s=arc-20240605;
 b=g+EusyGrMRoKqvYR9Vd4f6lDLh8qkvjLhKNsY2WrPIutPkxqZKtodLAjFGZ1J5ubnt
 wdcxCvfsW3Z8kz2rExtRveADfqqmquAnghVjzk/jjMmeSVpTDEl5+FluPFA1A5+nAGZF
 ZiRSR94Wp2uEoGMtzbudlJSRM9xMYjVhGyQ+VDSQAV8Jq+xuYl1+eSy3ouGiWrR1RXrI
 /zoM26iXDyCZRcn0DTIzGgzFtA+ER7GYb/raMcWsJfLISPkG0H+TwtPPFvg8WRbRf3IM
 KQVBTURDS6EWGnPVJrt2Jzb5b3/JeA41m4NZy3HRc6OsUzGKd8XQ3nosQeN9Gc6J04/e
 xDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=9VSfaSmZiuzc3OUajzl27LDOjRPp4i7hhVD2ZvkIMkg=;
 fh=Y96SSszlyBqOu5SSmjT2C/E1iZyPM7R5GW2tUGsW9kk=;
 b=RsBNKJfWMVfHt8ymDgEYJKkNSirap9i5VcEm96c1SURz/mjhsZAXgiQZ0oG/VF7/+G
 EgNLjNBcpH7t0SzvAFWsNBdaNYnXbsA3fT+1LavGLxWjyAbhDe8L/1iddAU9Pc8wlWl8
 QbD3kJnWAwt2Hiu3/stqibv1Yk7L6VvxfbnANunbku+uGjaBI8KXrk6jQBCb1YWFpGBX
 uWpP1Tbh7fhtE8Xv1bo+A8wOm6yMVzMouFO98Lwg/jp/RkQNFZRoKyPyYOzsGSBS4PNd
 5KPQWQEa9+/wT7ojXk0GUcW728yTiItX7xuTbjFnrAkGWaEIVFJspN2zarFWUlUoBa6A
 84Dg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780653895; x=1781258695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9VSfaSmZiuzc3OUajzl27LDOjRPp4i7hhVD2ZvkIMkg=;
 b=JIgG7r/o+WfUoUsuTrQnmKzYXTgSBAF5/JF0zlTK9qo1a3DGl9O6AtFGvkBt7wGFj0
 K8b/9IBUAUSQtnUtNg1R+jaUedYIiiGugXo92xrA7M33wUFXOpEf9AlDk0F0w5LDQkjz
 o0c7MU/nlUUopBLV4bopQOcpVE7Rn0dOdlsN+CEuq4PbeLU0LOSo+EQNazz7GKn6LzoM
 8Gxx4ij92sAdkQLjiZWrJX46M6xGbEM5cvPHCvmvANf963hiYx5pCTym1EEfASouNe3W
 lra8Xx29UDbytWDgwOGEWqm8JWK4Bkek5xceY0g1OgWIiZK2aBCKLM4L9xqpYq2ZpR9A
 qpMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+g0efrEOF+OG9Ns/3vQXsXDx6KVv40NlfQZl7Zh/adCu1xF9oEdm9YaNPqsQW5TXD9Kzp602u1gBI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzZHspDcCHtaHbmgKrpOivLDveT8xprsHyIhgkFmMK+k4mGhzT
 /7u5skA0/rJ8eP4PjwXT+sKlzst1+GrMD0rTr253dla9wnaCt5kKDzAsnbe1mfm9NS8kAm57t7k
 43Sgf5+6OEjCTanVOZ3LW8gDdZKeJCL/3nQcq6cBcByVuZMb7eDonLduhT5JL/Ecg/+mijpmb9G
 IQ1jdRxieYoWOhbBJom+DPkJANi0rNKK3SxdUZAk4zwJUZlTfLCtk3OAfjS+aR
X-Gm-Gg: Acq92OGhQoaPES0XpIOP84sAu4636UJVLPbnOIq2JhQ3vTz5xlSZg786LUZYbRZ29RT
 sYTcvlI8BUfF6nig1A3qqk7OwRjQfbqdRoE8fmk3D94+2mkW2q4w9pUNt9OxXqKvzFUTrvKxnuz
 TuF3aqTjFQii33YzaQwKTXp4POmJbWYegCXW9ArTgDpidKxJZidvZwuPnSERWuB+mHgWrK3Y5PN
 Ss6CSOq+5HZ5zWRLUk2CGxzZF0OWoChS9Xagqjwh/5YbSTNwp1KXzTzdgEDV7k3tz0VnwLR4xfS
 fViYOz+GLS6fH97W25ALTgKkgGIexuxRZ0Kl/25hrgDQ
X-Received: by 2002:a05:6808:250e:b0:467:de9:3eab with SMTP id
 5614622812f47-4868dd853c0mr820654b6e.1.1780653895211; 
 Fri, 05 Jun 2026 03:04:55 -0700 (PDT)
X-Received: by 2002:a05:6808:250e:b0:467:de9:3eab with SMTP id
 5614622812f47-4868dd853c0mr820640b6e.1.1780653894731; Fri, 05 Jun 2026
 03:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260505033558.157604-1-an.wu@canonical.com>
 <afuOnvFCEHEft4-R@intel.com>
 <CAO4Mv0bT4+W6E-Z-0=NSAj0ZjSqa7jFRDpLt4RxL-NgBux8yFA@mail.gmail.com>
In-Reply-To: <CAO4Mv0bT4+W6E-Z-0=NSAj0ZjSqa7jFRDpLt4RxL-NgBux8yFA@mail.gmail.com>
From: An Wu <an.wu@canonical.com>
Date: Fri, 5 Jun 2026 18:04:43 +0800
X-Gm-Features: AVHnY4IoniK44BP4Xi9qUidiocosUoS7vU6RQU3D0zIxQoBX8dugDVXxmqs0638
Message-ID: <CAO4Mv0ZwrHqXtSNEJ9GA0K+QXtRZYtrG1msHK2PM1t6_tzUb2A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915/tc: Recover AUX channel after external TC
 port mode change
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

Hi Jani, Imre, Ville,
    The patch is really not appropriate and also this issue should be
fixed elsewhere.
Therefore, I will drop this patch.
Appreciate your patience and sorry for the noise.

BR
    An

On Thu, May 7, 2026 at 9:58=E2=80=AFAM An Wu <an.wu@canonical.com> wrote:
>
> Hi Ville
> I have filed a bug (https://gitlab.freedesktop.org/drm/xe/kernel/-/work_i=
tems/7918)
> Thank you for your comment.
>
> BR
>     An
>
> On Thu, May 7, 2026 at 2:55=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4 <ville.syr=
jala@linux.intel.com> wrote:
>>
>> On Tue, May 05, 2026 at 11:35:57AM +0800, ChunAn Wu wrote:
>> > When Fn+F4 triggers mirror mode, the BIOS/EC reconfigures a TC port
>> > mode (e.g. DP-Alt to TBT-Alt via UCSI) without generating HPD. The
>> > driver's cached TC mode becomes stale, so intel_dp_aux_xfer() uses
>> > the wrong power domain and IO routing, and AUX transactions fail.
>> >
>> > This occurs when the USB-C-to-HDMI dongle does not support TBT, so
>> > the mode switch creates a mismatch. It also occurs with slow monitors
>> > whose delayed HPD/DDC/EDID recovery causes the Type-C layer to settle
>> > on a stale tbt-alt state before the dongle finishes re-negotiation.
>> >
>> > Add intel_tc_port_aux_recover() to detect hardware/cached TC mode
>> > divergence and reset the PHY. Wrap it with
>> > intel_dp_aux_xfer_with_recovery() to retry with corrected settings.
>> >
>> > Tested on Panther Lake and Lunar Lake with a BenQ HDMI monitor via
>> > USB-C-to-HDMI dongle.
>>
>> This sounds like a completely insane thing for the firmware to do.
>> It's not supposed to screw with the hardware while the driver is in
>> control.
>>
>> Please file a bug in gitlab and also attach full acpidumps there so
>> that we can check if that's where the insanity lives. This is isn't
>> some Fujitsu-Siemens laptop is it? Those have historically known to
>> do stupid stuff like this...
>>
>> >
>> > Signed-off-by: ChunAn Wu <an.wu@canonical.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_dp_aux.c | 41 +++++++++--
>> >  drivers/gpu/drm/i915/display/intel_tc.c     | 75 ++++++++++++++++++++=
+
>> >  drivers/gpu/drm/i915/display/intel_tc.h     |  1 +
>> >  3 files changed, 113 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu=
/drm/i915/display/intel_dp_aux.c
>> > index b20ec3e589fa..d496b2231656 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
>> > @@ -481,6 +481,39 @@ static u32 intel_dp_aux_xfer_flags(const struct d=
rm_dp_aux_msg *msg)
>> >       return 0;
>> >  }
>> >
>> > +/**
>> > + * intel_dp_aux_xfer_with_recovery - AUX transfer with TC port recove=
ry
>> > + * @intel_dp: the DP port
>> > + * @send: buffer of bytes to send
>> > + * @send_bytes: number of bytes to send
>> > + * @recv: buffer to store received reply
>> > + * @recv_size: maximum number of bytes to receive
>> > + * @aux_send_ctl_flags: extra flags for the AUX send control register
>> > + *
>> > + * Wrapper around intel_dp_aux_xfer() that attempts to recover from a=
n
>> > + * external TC port mode change (e.g., dp-alt -> tbt-alt via hotkey B=
IOS
>> > + * action) when the initial AUX transfer fails. On failure, recovery =
is
>> > + * attempted once via intel_tc_port_aux_recover() before retrying.
>> > + *
>> > + * Returns: number of received bytes on success, negative error code =
on failure.
>> > + */
>> > +static int
>> > +intel_dp_aux_xfer_with_recovery(struct intel_dp *intel_dp,
>> > +                             const u8 *send, int send_bytes,
>> > +                             u8 *recv, int recv_size,
>> > +                             u32 aux_send_ctl_flags)
>> > +{
>> > +     struct intel_digital_port *dig_port =3D dp_to_dig_port(intel_dp)=
;
>> > +     int ret;
>> > +
>> > +     ret =3D intel_dp_aux_xfer(intel_dp, send, send_bytes, recv, recv=
_size,
>> > +                             aux_send_ctl_flags);
>> > +     if (ret < 0 && intel_tc_port_aux_recover(dig_port))
>> > +             ret =3D intel_dp_aux_xfer(intel_dp, send, send_bytes, re=
cv,
>> > +                                     recv_size, aux_send_ctl_flags);
>> > +     return ret;
>> > +}
>> > +
>> >  static ssize_t
>> >  intel_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *=
msg)
>> >  {
>> > @@ -508,8 +541,8 @@ intel_dp_aux_transfer(struct drm_dp_aux *aux, stru=
ct drm_dp_aux_msg *msg)
>> >               if (msg->buffer)
>> >                       memcpy(txbuf + HEADER_SIZE, msg->buffer, msg->si=
ze);
>> >
>> > -             ret =3D intel_dp_aux_xfer(intel_dp, txbuf, txsize,
>> > -                                     rxbuf, rxsize, flags);
>> > +             ret =3D intel_dp_aux_xfer_with_recovery(intel_dp, txbuf,=
 txsize,
>> > +                                                   rxbuf, rxsize, fla=
gs);
>> >               if (ret > 0) {
>> >                       msg->reply =3D rxbuf[0] >> 4;
>> >
>> > @@ -531,8 +564,8 @@ intel_dp_aux_transfer(struct drm_dp_aux *aux, stru=
ct drm_dp_aux_msg *msg)
>> >               if (drm_WARN_ON(display->drm, rxsize > 20))
>> >                       return -E2BIG;
>> >
>> > -             ret =3D intel_dp_aux_xfer(intel_dp, txbuf, txsize,
>> > -                                     rxbuf, rxsize, flags);
>> > +             ret =3D intel_dp_aux_xfer_with_recovery(intel_dp, txbuf,=
 txsize,
>> > +                                                   rxbuf, rxsize, fla=
gs);
>> >               if (ret > 0) {
>> >                       msg->reply =3D rxbuf[0] >> 4;
>> >                       /*
>> > diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm=
/i915/display/intel_tc.c
>> > index a21dd4e3fe4c..1b23161e4eea 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_tc.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_tc.c
>> > @@ -1861,6 +1861,81 @@ void intel_tc_port_link_cancel_reset_work(struc=
t intel_digital_port *dig_port)
>> >       cancel_delayed_work(&tc->link_reset_work);
>> >  }
>> >
>> > +/**
>> > + * intel_tc_port_aux_recover - Recover AUX channel after external TC =
mode change
>> > + * @dig_port: digital port
>> > + *
>> > + * When firmware causes a TC port mode change (e.g., dp-alt -> discon=
nect ->
>> > + * tbt-alt) during a hotkey-triggered display mode switch, AUX transa=
ctions
>> > + * using the stale power domain and IO flags will fail with timeouts =
or errors.
>> > + * This happens because:
>> > + *
>> > + *   1. The display driver holds the TC link in dp-alt mode (link_ref=
count > 0)
>> > + *   2. Firmware (e.g., via HP WMI hotkey BIOS action) reconfigures t=
he TC port
>> > + *      mode externally without notifying the display driver
>> > + *   3. tc->mode stays as TC_PORT_DP_ALT while HW transitions to a di=
fferent
>> > + *      mode, invalidating the AUX power domain and IO flags used by
>> > + *      intel_dp_aux_xfer()
>> > + *
>> > + * This function detects the discrepancy between tc->mode and actual =
HW state,
>> > + * and re-synchronizes them via a TC PHY reset. After recovery, AUX r=
etries
>> > + * will use the correct power domain and control flags.
>> > + *
>> > + * The link_refcount is temporarily cleared to allow intel_tc_port_re=
set_mode()
>> > + * to proceed without the PHY-ownership assertion that fires when lin=
k_refcount
>> > + * is non-zero and firmware has already released PHY ownership.
>> > + *
>> > + * Must be called outside the TC port lock (tc->lock).
>> > + *
>> > + * Returns: %true if recovery was performed and AUX can be retried,
>> > + *          %false if recovery was not needed or not possible.
>> > + */
>> > +bool intel_tc_port_aux_recover(struct intel_digital_port *dig_port)
>> > +{
>> > +     struct intel_tc_port *tc;
>> > +     struct intel_display *display;
>> > +     bool recovered =3D false;
>> > +
>> > +     if (!intel_encoder_is_tc(&dig_port->base))
>> > +             return false;
>> > +
>> > +     tc =3D to_tc_port(dig_port);
>> > +     display =3D to_intel_display(dig_port);
>> > +
>> > +     mutex_lock(&tc->lock);
>> > +
>> > +     /*
>> > +      * Recovery is only needed when the link is actively held AND th=
e HW
>> > +      * TC mode has diverged from the driver's cached state.
>> > +      */
>> > +     if (!tc->link_refcount || !intel_tc_port_needs_reset(tc))
>> > +             goto out;
>> > +
>> > +     drm_dbg_kms(display->drm,
>> > +                 "Port %s: AUX recover: external TC mode change detec=
ted (%s -> HW), reconnecting TC PHY\n",
>> > +                 tc->port_name, tc_port_mode_name(tc->mode));
>> > +
>> > +     /*
>> > +      * Temporarily clear link_refcount so intel_tc_port_reset_mode()=
 can
>> > +      * run the PHY disconnect/connect cycle without the ownership as=
sertion
>> > +      * that fires when link_refcount > 0 and firmware has already re=
leased
>> > +      * PHY ownership externally.
>> > +      */
>> > +     tc->link_refcount =3D 0;
>> > +     intel_tc_port_reset_mode(tc, 1, false);
>> > +     tc->link_refcount =3D 1;
>> > +
>> > +     recovered =3D tc->mode !=3D TC_PORT_DISCONNECTED;
>> > +     if (!recovered)
>> > +             drm_warn(display->drm,
>> > +                      "Port %s: AUX recover: failed to restore TC por=
t mode\n",
>> > +                      tc->port_name);
>> > +
>> > +out:
>> > +     mutex_unlock(&tc->lock);
>> > +     return recovered;
>> > +}
>> > +
>> >  static void __intel_tc_port_lock(struct intel_tc_port *tc,
>> >                                int required_lanes)
>> >  {
>> > diff --git a/drivers/gpu/drm/i915/display/intel_tc.h b/drivers/gpu/drm=
/i915/display/intel_tc.h
>> > index 6719aea5bd58..d44998a3081a 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_tc.h
>> > +++ b/drivers/gpu/drm/i915/display/intel_tc.h
>> > @@ -108,6 +108,7 @@ bool intel_tc_port_ref_held(struct intel_digital_p=
ort *dig_port);
>> >  bool intel_tc_port_link_needs_reset(struct intel_digital_port *dig_po=
rt);
>> >  bool intel_tc_port_link_reset(struct intel_digital_port *dig_port);
>> >  void intel_tc_port_link_cancel_reset_work(struct intel_digital_port *=
dig_port);
>> > +bool intel_tc_port_aux_recover(struct intel_digital_port *dig_port);
>> >
>> >  int intel_tc_port_init(struct intel_digital_port *dig_port, bool is_l=
egacy);
>> >  void intel_tc_port_cleanup(struct intel_digital_port *dig_port);
>> > --
>> > 2.34.1
>>
>> --
>> Ville Syrj=C3=A4l=C3=A4
>> Intel

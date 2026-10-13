Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0419CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE31112167;
	Thu, 15 Oct 2026 07:56:55 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A971F10E8D0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:57:08 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-33e6279a1d7so1142782eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907028; cv=none;
 d=google.com; s=arc-20260327;
 b=S9SY+rH7TCTDx/Y45382W6+sQn8lDK2g4WdFLrLWtG7gE/dxGFlis5CfTPmyf9MVEG
 dqhh38Hv5DTOb5i2Gob2iYigqbzaAFzDmAeZd/XwqO+YCP2pEV1Rj0sv/ORFC7cSbzqt
 67Bv6JnvDzarxlJD2xRl5KEakA+FsxFrp6ZcK6MGXF3ULjk6dYs4ev/Uie+YDh/jwFxt
 eTHNUw/OGzAiOhWv+JxkxQDnlO+tQYaqE86zJhtVu2DJeS6uVCAPUOzOanrmuG+4gObl
 BMIKL3NKUPQpQXVMylLvFjri6fciI6k7DW2kmyZuVMYVI/SU41KNrFHvujf50IkGOLXE
 a9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PDLHHZ874d1ewnPTeyjpg+IPaJWngHOsJodfN6cZSrw=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=MtqB8VCTvSvdvglaq/xlBmBp/5whOuYxP85pRnrSccygJefojzduYCqMaxc3qSfJtF
 0wuHXAgoxfNXC55exu8h+Gx+CnbuQcg5B7jS9QOtC6gcAsOdYoLoSVPCExxAfHlUDOLf
 42oBPur68+m1SSaVr/4MGcI+viyBO6+iSH96ek22lPet2wKdw/ar5VqU+hcxLCAXVBVS
 MF7+ZM6PPFezKg0njVUKU6K1K1HsS/2heR9rykVfmCojaehrBEU0bLWaJBMELMcFObei
 4c912X64AI4AkKk9eSgLnElX1QgojuwN2k4pllrNGknvHCj2baCRMxp1YilWbeZ1mm0d
 r6Hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791907028; x=1792511828; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PDLHHZ874d1ewnPTeyjpg+IPaJWngHOsJodfN6cZSrw=;
 b=KsoZMg4o6ln9xFGHBNPWvZV2hI8XwRZrj6FQfi25IrKHfUUPlk20DnjAM94+Z54VBb
 Badw9lEjSAXDTF65B8qbGC70lf7HYHShiASAM6tcL8bMH1qBXOcK65T5DBmqCQ/ZEd/U
 Tw5GMZrRx6hSa6Jfyk/2VlXAx4QnKC1eo9HBDPfmlWDsqesoDN8vZqQ+VvM+s0MfneWH
 8hDx8dn7DUTcoH2B3ZJZvtTJ1EjK+JwnayivbF+9otyu82IkSyTDDHFQLiatMle0lfvJ
 CQarmywkoAkAsuWEefWSZXrAeYLNKdfhpZvGgCky5bDoGGwRopn+RBEMfO0P5sh51wtM
 jRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907028; x=1792511828;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PDLHHZ874d1ewnPTeyjpg+IPaJWngHOsJodfN6cZSrw=;
 b=bex7qK7OAWvoz0oNouILqV7DKlNFDDHvKoid69quJGgfmYU1+uaxmtY928uuu+sM5z
 L2g8RjlY53+aPPz3QdY0ic9ourNMrfcpv9HIq/7ueXvGK0SqYZBvOtu4c36cQZNAwT6X
 1N9d0A16KR4qrq5WtuQtNeigvA7BTqNIw9zR6xHziIgUk4Shy4UEVzO+Z+9Ww7AZbD5y
 Iq8g9bFhZknDB7yjGMm5UB6vyuOsh9h5cq3FxD7gyGEq8MjKD+5lRCUeUNe7iY3tJ+oh
 WrRClrV6V4UkvKKdbEdPj5HCIQrd8TJC/072uFTvX04bByglJoAUbVDzgRBfRKRYOS/8
 OmNQ==
X-Gm-Message-State: AFq9FYLXGFQTkJBT+lIF6WYodCv/JxNgtyqErS9sKQRn+6gOjAcZI+8H
 8rcWnmKTzXc4rQ0ME5Y82BrzISLnEP9pEA+whXlPYfTcx+CDIcIRR4hkxdxCah8pBu/LtUKUkrC
 wD0Ov8BhAJgHUWXD6gVpwjU3sHQZwrxk4yqC5Z+g=
X-Gm-Gg: AYBFou0lK4kg+b90PpnxHyEbXtABZInS+2d+SUP4iRX/rm/a9VDRxf1Oc5M1d1Isihm
 ValOkn4JJs7TujRqfjAWPS0E5VMMgKyPjIGT+clJ5FGFCl79Zk82GwVnVAfwckJNv8VpiWtmdRk
 q+EG9iBRSDu/dQOdqtefYAZ3EIMN6jRO6BvzvDgzPwgcIYGEFs06fT5WuqY9l19kXla0rnHFHAa
 fJZebvzYwktuBe5bkDOPlT75mEEXuZxhLrVeaF2je++sTU1rcrHKQ76D6gcywB/0LhmrBOKay9E
 GGXa+/rq7GlnMMJFp5ysTO7wsjCdVOqI819wq30F8OD7HMhAeBEAZ+mS5g==
X-Received: by 2002:a05:7301:6191:10b0:359:9e84:dc89 with SMTP id
 5a478bee46e88-3599e84e944mr11102523eec.36.1791907027629; Tue, 13 Oct 2026
 08:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261012190249.3167-1-henryzhang62@gmail.com>
 <20261012190249.3167-3-henryzhang62@gmail.com>
 <sashiko-outbox-168575@kernel.org>
In-Reply-To: <sashiko-outbox-168575@kernel.org>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Tue, 13 Oct 2026 08:56:55 -0700
X-Gm-Features: AclHuK-nEW3HfbUJBO5QsA4Y8eql9gDHcYo8JMG1HwuspwfJzxBRKOhm50Si41E
Message-ID: <CANTW0ypOcO4F4icwh9SxFsqLuDUfYaKxe2K2NmAsyJP6RRVKTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vc4: dsi: Recover from a timed-out transfer
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000da4e48065dbadd09"
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

--000000000000da4e48065dbadd09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:16=E2=80=AFPM <sashiko-bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> - [High] drm/vc4: dsi: premature controller enable during timeout reset
> causes hardware instability
> - [High] drm/vc4: dsi: spurious completion due to IRQ handler TOCTOU race
> - [Medium] drm/vc4: missing mutex serialization in DSI host transfer
> --
> Thanks for the review.
>
> 1. Agreed. Mainline's pre_enable ungates the block only after the PHY
>    timings, timeouts and DISP1 are programmed; the restore must follow
>    the same order. Will fix in v2.
> 2. Agreed. The race predates this patch, but the timeout path is the
>    right place to close it; v2 will call synchronize_irq() before the
>    reset.
> 3. vc4_dsi_host_transfer() has never serialized transfers. I'll add a
>    separate patch in v2 that takes a mutex around host transfers.
>
> Henry
>



> commit b73bc40cfc01c81e251315be152ff0c2c6aa9361
> Author: Henry Zhang <henryzhang62@gmail.com>
>
> drm/vc4: dsi: Recover from a timed-out transfer
>
> When a transfer times out, vc4_dsi_host_transfer() disables the command,
> resets the FIFOs and returns -ETIMEDOUT. This commit adds a recovery
> mechanism that resets the DSI block and its analog front end after a
> timeout and restores the configuration so DSI keeps working without a
> modeset.
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.=
c
> index c092a1aaf700a..3783ff3eeac97 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> [ ... ]
> @@ -1359,6 +1358,93 @@ static ssize_t vc4_dsi_host_transfer(struct
> mipi_dsi_host *host,
>         return ret;
>  }
>
> +/*
> + * Reset the DSI block and its analog front end, then restore the
> + * configuration done in pre_enable. Resetting the FIFOs alone does not
> + * clear the state the block can be left in after a transfer timed out
> + * (e.g. on an LP receive timeout): every following transfer then times
> + * out as well, until the next modeset.
> + */
> +static void vc4_dsi_reset_and_restore(struct vc4_dsi *dsi)
> +{
> +       u32 ctrl =3D DSI_PORT_READ(CTRL);
> +       u32 afec0 =3D DSI_PORT_READ(PHY_AFEC0);
> [ ... ]
> +       DSI_PORT_WRITE(DISP0_CTRL, disp0);
> +       DSI_PORT_WRITE(TXPKT1C, 0);
> +       DSI_PORT_WRITE(CTRL, DSI_CTRL_SOFT_RESET_CFG |
> +                      DSI_PORT_BIT(CTRL_RESET_FIFOS));
> +       DSI_PORT_WRITE(PHY_AFEC0, afec0 | DSI_PORT_BIT(PHY_AFEC0_RESET));
> +       /* AFEC reset hold time */
> +       mdelay(1);
> +
> +       DSI_PORT_WRITE(CTRL, ctrl & ~DSI_CTRL_CAL_BYTE);
> +       DSI_PORT_WRITE(HSTX_TO_CNT, hstx_to);
> +       DSI_PORT_WRITE(LPRX_TO_CNT, lprx_to);
>
> [Severity: High]
> Can writing ctrl & ~DSI_CTRL_CAL_BYTE back to CTRL prematurely un-gate an=
d
> enable the controller before the subsequent writes to timing and PHY
> configuration registers?
>
> Since ctrl was read while a transfer was in progress, it contains the
> enable
> bit (DSI0_CTRL_CTRL0 or DSI1_CTRL_EN).
>
> Writing it back here enables the hardware block before its timings
> (HSTX_TO_CNT, HS_CLT0, PHYC, etc.) are restored, which could cause errati=
c
> bus
> behavior and unrecoverable hardware states.
>
> > +     DSI_PORT_WRITE(TA_TO_CNT, ta_to);
> [ ... ]
> +static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
> +                                    const struct mipi_dsi_msg *msg)
> +{
> +       struct vc4_dsi *dsi =3D host_to_dsi(host);
> +       u32 disp0_ctrl;
> +       ssize_t ret;
> +
> +       ret =3D vc4_dsi_transfer(dsi, msg);
>
> [Severity: Medium]
> Does this entry point need a mutex to serialize concurrent transfers?
>
> If user-space concurrently triggers DCS commands (e.g., via sysfs backlig=
ht
> updates and DRM KMS modesets), they can race because vc4_dsi_transfer()
> modifies shared variables like dsi->xfer_completion without a lock.
>
> With this patch, a timeout caused by such a race now triggers a full bloc=
k
> reset in vc4_dsi_reset_and_restore(), disrupting any interleaved concurre=
nt
> transfer.
>
> +       if (ret !=3D -ETIMEDOUT)
> +               return ret;
> +
> +       /*
> +        * Leave the block usable for the next transfer. The message is n=
ot
> +        * resent: it may already have reached the peripheral, and only t=
he
> +        * caller knows whether it is safe to repeat.
> +        */
> +       disp0_ctrl =3D DSI_PORT_READ(DISP0_CTRL);
> +       dev_warn(&dsi->pdev->dev,
> +                "transfer timed out (stat 0x%08x), resetting DSI\n",
> +                DSI_PORT_READ(STAT));
> +       vc4_dsi_reset_and_restore(dsi);
> +       DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
> +
> +       return ret;
> +}
>
> [Severity: High]
> Can a timed-out transfer cause a spurious completion of a subsequent
> transfer?
>
> If vc4_dsi_transfer() times out, wait_for_completion_timeout() returns.
> However, if the hardware interrupt had fired and the threaded IRQ handler
> (vc4_dsi_irq_handler) was preempted before calling
> complete(&dsi->xfer_completion), it could still be pending.
>
> Since there is no synchronization (like synchronize_irq()) in this timeou=
t
> recovery path to wait for the IRQ handler to finish, it returns
> immediately.
>
> The caller might retry the transfer, reinitializing dsi->xfer_completion.
> The
> preempted IRQ thread could then resume, calling complete() and falsely
> waking up
> the new transfer prematurely while the hardware is still busy.
>
> --
> Sashiko AI review =C2=B7
> https://sashiko.dev/#/patchset/20261012190249.3167-1-henryzhang62@gmail.c=
om?part=3D2
>

--000000000000da4e48065dbadd09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 12,=
 2026 at 12:16=E2=80=AFPM &lt;<a href=3D"mailto:sashiko-bot@kernel.org">sas=
hiko-bot@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Thank you for your contribution! Sashiko AI review found=
 3 potential issue(s) to consider:<br>
- [High] drm/vc4: dsi: premature controller enable during timeout reset cau=
ses hardware instability<br>
- [High] drm/vc4: dsi: spurious completion due to IRQ handler TOCTOU race<b=
r>
- [Medium] drm/vc4: missing mutex serialization in DSI host transfer<br>
--<br>
Thanks for the review.<br><br>1. Agreed. Mainline&#39;s pre_enable ungates =
the block only after the PHY<br>=C2=A0 =C2=A0timings, timeouts and DISP1 ar=
e programmed; the restore must follow<br>=C2=A0 =C2=A0the same order. Will =
fix in v2.<br>2. Agreed. The race predates this patch, but the timeout path=
 is the<br>=C2=A0 =C2=A0right place to close it; v2 will call synchronize_i=
rq() before the<br>=C2=A0 =C2=A0reset.<br>3. vc4_dsi_host_transfer() has ne=
ver serialized transfers. I&#39;ll add a<br>=C2=A0 =C2=A0separate patch in =
v2 that takes a mutex around host transfers.<br><br>Henry<br>=C2=A0</blockq=
uote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">com=
mit b73bc40cfc01c81e251315be152ff0c2c6aa9361<br>
Author: Henry Zhang &lt;<a href=3D"mailto:henryzhang62@gmail.com" target=3D=
"_blank">henryzhang62@gmail.com</a>&gt;<br>
<br>
drm/vc4: dsi: Recover from a timed-out transfer<br>
<br>
When a transfer times out, vc4_dsi_host_transfer() disables the command,<br=
>
resets the FIFOs and returns -ETIMEDOUT. This commit adds a recovery<br>
mechanism that resets the DSI block and its analog front end after a<br>
timeout and restores the configuration so DSI keeps working without a<br>
modeset.<br>
<br>
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c<=
br>
index c092a1aaf700a..3783ff3eeac97 100644<br>
--- a/drivers/gpu/drm/vc4/vc4_dsi.c<br>
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c<br>
[ ... ]<br>
@@ -1359,6 +1358,93 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi=
_host *host,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Reset the DSI block and its analog front end, then restore the<br>
+ * configuration done in pre_enable. Resetting the FIFOs alone does not<br=
>
+ * clear the state the block can be left in after a transfer timed out<br>
+ * (e.g. on an LP receive timeout): every following transfer then times<br=
>
+ * out as well, until the next modeset.<br>
+ */<br>
+static void vc4_dsi_reset_and_restore(struct vc4_dsi *dsi)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 ctrl =3D DSI_PORT_READ(CTRL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 afec0 =3D DSI_PORT_READ(PHY_AFEC0);<br>
[ ... ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(DISP0_CTRL, disp0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(TXPKT1C, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(CTRL, DSI_CTRL_SOFT_RESET_CFG |<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DSI_PORT_BIT(CTRL_RESET_FIFOS));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(PHY_AFEC0, afec0 | DSI_PORT_BIT(=
PHY_AFEC0_RESET));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* AFEC reset hold time */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(CTRL, ctrl &amp; ~DSI_CTRL_CAL_B=
YTE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(HSTX_TO_CNT, hstx_to);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(LPRX_TO_CNT, lprx_to);<br>
<br>
[Severity: High]<br>
Can writing ctrl &amp; ~DSI_CTRL_CAL_BYTE back to CTRL prematurely un-gate =
and<br>
enable the controller before the subsequent writes to timing and PHY<br>
configuration registers?<br>
<br>
Since ctrl was read while a transfer was in progress, it contains the enabl=
e<br>
bit (DSI0_CTRL_CTRL0 or DSI1_CTRL_EN).<br>
<br>
Writing it back here enables the hardware block before its timings<br>
(HSTX_TO_CNT, HS_CLT0, PHYC, etc.) are restored, which could cause erratic =
bus<br>
behavior and unrecoverable hardware states.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(TA_TO_CNT, ta_to);<br>
[ ... ]<br>
+static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct mipi_dsi_=
msg *msg)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vc4_dsi *dsi =3D host_to_dsi(host);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 disp0_ctrl;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vc4_dsi_transfer(dsi, msg);<br>
<br>
[Severity: Medium]<br>
Does this entry point need a mutex to serialize concurrent transfers?<br>
<br>
If user-space concurrently triggers DCS commands (e.g., via sysfs backlight=
<br>
updates and DRM KMS modesets), they can race because vc4_dsi_transfer()<br>
modifies shared variables like dsi-&gt;xfer_completion without a lock.<br>
<br>
With this patch, a timeout caused by such a race now triggers a full block<=
br>
reset in vc4_dsi_reset_and_restore(), disrupting any interleaved concurrent=
<br>
transfer.<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D -ETIMEDOUT)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Leave the block usable for the next transfer=
. The message is not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * resent: it may already have reached the peri=
pheral, and only the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * caller knows whether it is safe to repeat.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0disp0_ctrl =3D DSI_PORT_READ(DISP0_CTRL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(&amp;dsi-&gt;pdev-&gt;dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transfer tim=
ed out (stat 0x%08x), resetting DSI\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DSI_PORT_READ(STAT=
));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vc4_dsi_reset_and_restore(dsi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
<br>
[Severity: High]<br>
Can a timed-out transfer cause a spurious completion of a subsequent transf=
er?<br>
<br>
If vc4_dsi_transfer() times out, wait_for_completion_timeout() returns.<br>
However, if the hardware interrupt had fired and the threaded IRQ handler<b=
r>
(vc4_dsi_irq_handler) was preempted before calling<br>
complete(&amp;dsi-&gt;xfer_completion), it could still be pending.<br>
<br>
Since there is no synchronization (like synchronize_irq()) in this timeout<=
br>
recovery path to wait for the IRQ handler to finish, it returns immediately=
.<br>
<br>
The caller might retry the transfer, reinitializing dsi-&gt;xfer_completion=
. The<br>
preempted IRQ thread could then resume, calling complete() and falsely waki=
ng up<br>
the new transfer prematurely while the hardware is still busy.<br>
<br>
-- <br>
Sashiko AI review =C2=B7 <a href=3D"https://sashiko.dev/#/patchset/20261012=
190249.3167-1-henryzhang62@gmail.com?part=3D2" rel=3D"noreferrer" target=3D=
"_blank">https://sashiko.dev/#/patchset/20261012190249.3167-1-henryzhang62@=
gmail.com?part=3D2</a><br>
</blockquote></div></div>

--000000000000da4e48065dbadd09--

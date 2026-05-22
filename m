Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345E3CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD5410E174;
	Fri, 22 May 2026 14:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J9xVlDSl";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB59910E174
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:54:05 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3697c35eab7so4403900a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779461645; cv=none;
 d=google.com; s=arc-20240605;
 b=ZRYftSB0tAdZ3cKgIvcFgkJK9rfO/BOQ4UU9S9MwUkuMIx0lJqIVCLlL4wKgC9gWl7
 OK0IHlGSugpQ+8N9KYyqtZ17Isv2XZ7zWEbdGZ7+rG4kG8+jOCA79cNxSTtxHu6Ib59B
 mr2O+/rU0qaZHIUdqpKTqafGDoa+NAz9Bg4q+OfuqLxZpFr/gUvL6/NENyS9NZRAtKNk
 CAXwtyTxuLk3iQqOAcytLvXXkUngVWTjyerU+s+ha2XpHNUbb9Bp+iDaY2435LP2f0YV
 v44zD3q9WmFh1g7U4qvybz8fXF9vPUd6dbqTEFV6A1UO4/IdPz3qGL7a7nJz6hfs4FXq
 VViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ps/2Gk+8FfowrfQGOc2KHJFg170mzRbRXtraK7vYZlk=;
 fh=8tlheTWa9lW5lwGwt5oWl5xwzCyTZCr7M4f0sL5bXgQ=;
 b=McoDNyrrxFifmmjJs0Oml0Hd1CvnutZ0H8ylIgmFSoiTeP996YC4nhk+iGTbyzHr1I
 Cgjwnxj9bXmr6WoJthDL39RgKasyVcMtYawndJCjjD/qqCF4zLgtkpTW5wMcC0qgjgLs
 8JyWwMEjDpZpLhSR03XIk9yLjRhfW38n5qcKwjP5HrmxB4v9xCadQOTMx7y5YxakwkxY
 47mbTN3G9m0ZIl/DOfbgO8XQeEWpXj4n5vvP02H5mV5QKUDOYqMrYKP1igHVMmoedpN9
 WHSMMJgxCpe9bIKy51IVrSP25eeTBsU558ylUBJfU1C/IpImA13Rd2vPU4KU/MEQLN5a
 PzhA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779461645; x=1780066445; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ps/2Gk+8FfowrfQGOc2KHJFg170mzRbRXtraK7vYZlk=;
 b=J9xVlDSlRevdfQE1bvqz9W/WAr3AyPN0A+ODgtvzEAWeI9emcJE3M7Ccfm9W/koFSv
 6CjJ1Q+TV5d82w0vGl3yC1854BdAmk2e6bvqYeGNLo2B4n+isqcMEtr56t4apq3r1iTv
 V0Px8w8Pe0nj5IPAr+96tCQtmyHnn9iK3yEUzGHbuKsFBprODbYuLTqZPKiOd0xJfySL
 8LmP3QeXPlwKaQ4UUeYhK0DuxMBtFth52z53jOtN3iu0gpr8xtQQjpUTErPbISrop25b
 v3fPvhgbDnebwW+9pG+TgcqpdoZUkM4VRTgypIR5F7zTF2bR+IKdKAq/1Hqp3Zw8fRUR
 Ia8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461645; x=1780066445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ps/2Gk+8FfowrfQGOc2KHJFg170mzRbRXtraK7vYZlk=;
 b=j/zJgMtbzEQJGF9c1CAw3TqspMgsh4Al0MAOxRg4xE5ZefmRdQ5sg0TPdxcIf8xPrg
 pA0uHjQjGL45Nr7i5/rnEBbvkjNyWrbls164g4eaf+1onI0PPr98tn+uPX5lqs6MJw4q
 uXgL2SUBbJmBUoN3DFanRkevX1XeYLnfScBTpV8j1x64pyf7qNI7aA0RlTlhXCsSCMI6
 HPBPwuNwLuJldr86WMWzD+hz2RD/QgUhnS2+xwB6GaPu8lx4+m5E+yAvioCAbCWg8g8/
 oDEGvTZCheOWsQ237/eGMvSoVwoKLNXM1FYoWPew7hqSkw7VCoXBynx4s8dy3yp6KPv3
 omUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ppN9bhs6fAxTjs66SsqNsWMpXzHqks0A4qIkv70d560Wu8KVruuJFI7lGr+Iya//iQ4xxoUstaY0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw8vShS8e5swn2x1o6ZC+u5NAa0C76Tzp10+6GLvCXayaF/8BM
 QQHND5Ny7Br/H0pX6rytu0QAdb6sBzrp6TIyT091pwXoq2M/ah3hiQpZALybQjBXGyg6m0QPbHO
 ORowvJSbAWEw2vvKRY55v6bJpeqs4jiI=
X-Gm-Gg: Acq92OHwKqmB5oWyFdVDQVejDXyJYkk/KkL32WnrucTnKQJgr01vm6bmm0jZ80iBzBn
 ZpH+L2VEYhseeKY1+aZRa6SMKprE8AC7b0M8mFOGfTuowtcKgByt5jkLWMXj7W8jmAJ7+GvBRXC
 K2UdsWYGwu3Cop5tPtRGQ62V+6dYmKejWOQUu7rlvVwEQpccJ+WMCCFunKP4Brt0dQ21BIoviDR
 +0jZy6ZOgJ1n9k+Xc/LHw5Ca7msGS70ZuwWHQX6QypVAHzjzXFv/4xt9oWaXvoe1Akebw9Q23ae
 JHhu1AvWu0UoHI5/x64xVED8fHHUSMPtbg7l8uLpy2hpkcbhNv1oAJjFrhPK0tWLsEmiGQ1zqQx
 CH1HiH/tIdmYoCmiKhhAIWTscj/C+33x17SbHIjE=
X-Received: by 2002:a17:90b:564f:b0:35b:e5ce:73bb with SMTP id
 98e67ed59e1d1-36a676f5108mr3560675a91.1.1779461645095; Fri, 22 May 2026
 07:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260518034252.16337-1-chintanlike@gmail.com>
 <CAD=FV=X5rc3zponA7rOPyttv8U0JXadrkJ89S8O2M=ahGMinTw@mail.gmail.com>
In-Reply-To: <CAD=FV=X5rc3zponA7rOPyttv8U0JXadrkJ89S8O2M=ahGMinTw@mail.gmail.com>
From: Chintan Patel <chintanlike@gmail.com>
Date: Fri, 22 May 2026 07:53:52 -0700
X-Gm-Features: AVHnY4J3HzgjqXHWpIx0gcs4FU5dlNqrM2TdUMhMJY_lqk2yThNVduJ5I-o1zNw
Message-ID: <CAAL9DyCep+R-JNHbRPWH5-97myzPLgwbx-+LjF=twWov=Q3jsA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: novatek-nt36672a: Inline panel init
 sequences
To: Doug Anderson <dianders@chromium.org>
Cc: sumit.semwal@linaro.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000003f566806526933f4"
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

--0000000000003f566806526933f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:37=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:

> Hi,
>
> On Sun, May 17, 2026 at 8:43=E2=80=AFPM Chintan Patel <chintanlike@gmail.=
com>
> wrote:
> >
> > @@ -55,13 +51,9 @@ struct nt36672a_panel_desc {
> >         enum mipi_dsi_pixel_format format;
> >         unsigned int lanes;
> >
> > -       unsigned int num_on_cmds_1;
> > -       const struct nt36672a_panel_cmd *on_cmds_1;
> > -       unsigned int num_on_cmds_2;
> > -       const struct nt36672a_panel_cmd *on_cmds_2;
> > -
> > -       unsigned int num_off_cmds;
> > -       const struct nt36672a_panel_cmd *off_cmds;
> > +       void (*on_init_1)(struct mipi_dsi_multi_context *dsi_ctx);
> > +       void (*on_init_2)(struct mipi_dsi_multi_context *dsi_ctx);
> > +       void (*off_init)(struct mipi_dsi_multi_context *dsi_ctx);
>
> nit: The name "off_init" sounds a little strange to me. Maybe the
> three functions could be:
>
> send_init_cmds_1
> send_init_cmds_2
> send_deinit_cmds
>

Good point, agreed that off_init is a bit awkward naming-wise.

I'll rename these to something along the lines of:

send_init_cmds_1
send_init_cmds_2
send_deinit_cmds

in the next revision.


> ...or something like that?
>
> > +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x22);
>
> nit: I wouldn't block landing the patch for it, but since we're
> touching all this code it would be nice to make things lowercase hex.
> 0xff instead of 0xFF. That's the kernel standard, even if there are
> some drivers that violate it.
>
> Make sense - will do in v3.


>
> > +       for (reg =3D 0x02; reg <=3D 0x10; reg++)
> > +               mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x40);
> So I was curious about if the "for" loops helped out. They seem to.
>
> Overall, your change increased the size of the driver by quite a bit,
> but I guess that's the price we pay since (when we talked about this
> in the past) people really didn't like the table-based approach. Old
> driver vs. with your changes:
>
> $ ./scripts/bloat-o-meter panel-novatek-nt36672a-old.ko
> panel-novatek-nt36672a-new.ko
> add/remove: 9/3 grow/shrink: 2/5 up/down: 10430/-1712 (8718)
> Function                                     old     new   delta
> .Ltmp1                                      1292    4652   +3360
> $x                                          1392    4752   +3360
> tianma_fhd_video_on_init_1                     -    3148   +3148
> tianma_fhd_video_on_init_1.d                   -     252    +252
> tianma_fhd_video_on_init_2                     -     144    +144
> tianma_fhd_video_off_init                      -     124    +124
> tianma_fhd_video_on_init_2.d                   -      10     +10
> tianma_fhd_video_off_init.d                    -       8      +8
> .Ltmp8                                         -       8      +8
> .Ltmp7                                         -       8      +8
> .Ltmp6                                         -       8      +8
> tianma_fhd_video_off_cmds                      8       -      -8
> tianma_fhd_video_on_cmds_2                    10       -     -10
> tianma_fhd_video_panel_desc                   88      64     -24
> nt36672a_panel_unprepare                     244     212     -32
> nt36672a_panel_prepare                       340     284     -56
> $d                                          3555    3331    -224
> tianma_fhd_video_on_cmds_1                   562       -    -562
> .Ltmp3                                       804       8    -796
> Total: Before=3D11206, After=3D19924, chg +77.80%
>
> ...but if we hadn't done the "for" loops, it would have been much worse:
>
> dianders@dianders:v6.6 ((8953acf077cf...))$ ./scripts/bloat-o-meter
> panel-novatek-nt36672a-old.ko panel-novatek-nt36672a-new-noloops.ko
> add/remove: 9/3 grow/shrink: 4/4 up/down: 18380/-1488 (16892)
> Function                                     old     new   delta
> .Ltmp1                                      1292    7164   +5872
> $x                                          1392    7264   +5872
> tianma_fhd_video_on_init_1                     -    5664   +5664
> tianma_fhd_video_on_init_1.d                   -     562    +562
> tianma_fhd_video_on_init_2                     -     144    +144
> tianma_fhd_video_off_init                      -     124    +124
> $d                                          3555    3649     +94
> tianma_fhd_video_on_init_2.d                   -      10     +10
> tianma_fhd_video_off_init.d                    -       8      +8
> .Ltmp8                                         -       8      +8
> .Ltmp7                                         -       8      +8
> .Ltmp6                                         -       8      +8
> __UNIQUE_ID_modinfo_411                       79      85      +6
> tianma_fhd_video_off_cmds                      8       -      -8
> tianma_fhd_video_on_cmds_2                    10       -     -10
> tianma_fhd_video_panel_desc                   88      64     -24
> nt36672a_panel_unprepare                     244     212     -32
> nt36672a_panel_prepare                       340     284     -56
> tianma_fhd_video_on_cmds_1                   562       -    -562
> .Ltmp3                                       804       8    -796
> Total: Before=3D11206, After=3D28098, chg +150.74%
>
> ...and even the shortest "for" loop you added made a difference. ;-)
>
> So I'm good with it, though I'd prefer that you send a new version (if
> possible) since the "off_init" really bothers me for some reason. ;-P
>
> I'll also note that I did some hacky testing to confirm that your
> "for" loops do indeed create the same set of commands as we had before
> your patch.
>

Thanks a lot for the detailed review and for running the bloat-o-meter
comparisons.

Yeah, the code size growth is unfortunately larger than I'd hoped, but
the loop-based cleanup at least seems to keep it within something more
reasonable. Thanks also for verifying that the generated command
sequences still match the original tables.


> In any case:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>

--0000000000003f566806526933f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBUaHUsIE1heSAyMSwgMjAyNiBhdCA1OjM34oCvUE0gRG91ZyBBbmRlcnNv
biAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRpYW5kZXJzQGNocm9taXVtLm9yZyI+ZGlhbmRlcnNAY2hy
b21pdW0ub3JnPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHgg
c29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSw8YnI+DQo8YnI+DQpP
biBTdW4sIE1heSAxNywgMjAyNiBhdCA4OjQz4oCvUE0gQ2hpbnRhbiBQYXRlbCAmbHQ7PGEgaHJl
Zj0ibWFpbHRvOmNoaW50YW5saWtlQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmNoaW50YW5s
aWtlQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7IEBAIC01NSwx
MyArNTEsOSBAQCBzdHJ1Y3QgbnQzNjY3MmFfcGFuZWxfZGVzYyB7PGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgZW51bSBtaXBpX2RzaV9waXhlbF9mb3JtYXQgZm9ybWF0Ozxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoHVuc2lnbmVkIGludCBsYW5lczs8YnI+DQomZ3Q7PGJyPg0KJmd0OyAtwqAgwqAgwqAg
wqB1bnNpZ25lZCBpbnQgbnVtX29uX2NtZHNfMTs8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoGNvbnN0
IHN0cnVjdCBudDM2NjcyYV9wYW5lbF9jbWQgKm9uX2NtZHNfMTs8YnI+DQomZ3Q7IC3CoCDCoCDC
oCDCoHVuc2lnbmVkIGludCBudW1fb25fY21kc18yOzxicj4NCiZndDsgLcKgIMKgIMKgIMKgY29u
c3Qgc3RydWN0IG50MzY2NzJhX3BhbmVsX2NtZCAqb25fY21kc18yOzxicj4NCiZndDsgLTxicj4N
CiZndDsgLcKgIMKgIMKgIMKgdW5zaWduZWQgaW50IG51bV9vZmZfY21kczs8YnI+DQomZ3Q7IC3C
oCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBudDM2NjcyYV9wYW5lbF9jbWQgKm9mZl9jbWRzOzxicj4N
CiZndDsgK8KgIMKgIMKgIMKgdm9pZCAoKm9uX2luaXRfMSkoc3RydWN0IG1pcGlfZHNpX211bHRp
X2NvbnRleHQgKmRzaV9jdHgpOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgdm9pZCAoKm9uX2luaXRf
Mikoc3RydWN0IG1pcGlfZHNpX211bHRpX2NvbnRleHQgKmRzaV9jdHgpOzxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgdm9pZCAoKm9mZl9pbml0KShzdHJ1Y3QgbWlwaV9kc2lfbXVsdGlfY29udGV4dCAq
ZHNpX2N0eCk7PGJyPg0KPGJyPg0Kbml0OiBUaGUgbmFtZSAmcXVvdDtvZmZfaW5pdCZxdW90OyBz
b3VuZHMgYSBsaXR0bGUgc3RyYW5nZSB0byBtZS4gTWF5YmUgdGhlPGJyPg0KdGhyZWUgZnVuY3Rp
b25zIGNvdWxkIGJlOjxicj4NCjxicj4NCnNlbmRfaW5pdF9jbWRzXzE8YnI+DQpzZW5kX2luaXRf
Y21kc18yPGJyPg0Kc2VuZF9kZWluaXRfY21kczxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+R29vZCBwb2ludCwgYWdyZWVkIHRoYXQgb2ZmX2luaXQgaXMgYSBiaXQgYXdrd2FyZCBuYW1p
bmctd2lzZS48YnI+PGJyPkkmIzM5O2xsIHJlbmFtZSB0aGVzZSB0byBzb21ldGhpbmcgYWxvbmcg
dGhlIGxpbmVzIG9mOjxicj48YnI+c2VuZF9pbml0X2NtZHNfMTxicj5zZW5kX2luaXRfY21kc18y
PGJyPnNlbmRfZGVpbml0X2NtZHM8YnI+PGJyPjxkaXY+aW4gdGhlIG5leHQgcmV2aXNpb24uPC9k
aXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCi4uLm9yIHNvbWV0aGluZyBsaWtlIHRoYXQ/PGJyPg0K
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqBtaXBpX2RzaV9kY3Nfd3JpdGVfc2VxX211bHRpKGRzaV9j
dHgsIDB4RkYsIDB4MjIpOzxicj4NCjxicj4NCm5pdDogSSB3b3VsZG4mIzM5O3QgYmxvY2sgbGFu
ZGluZyB0aGUgcGF0Y2ggZm9yIGl0LCBidXQgc2luY2Ugd2UmIzM5O3JlPGJyPg0KdG91Y2hpbmcg
YWxsIHRoaXMgY29kZSBpdCB3b3VsZCBiZSBuaWNlIHRvIG1ha2UgdGhpbmdzIGxvd2VyY2FzZSBo
ZXguPGJyPg0KMHhmZiBpbnN0ZWFkIG9mIDB4RkYuIFRoYXQmIzM5O3MgdGhlIGtlcm5lbCBzdGFu
ZGFyZCwgZXZlbiBpZiB0aGVyZSBhcmU8YnI+DQpzb21lIGRyaXZlcnMgdGhhdCB2aW9sYXRlIGl0
Ljxicj4NCjxicj48L2Jsb2NrcXVvdGU+TWFrZSBzZW5zZSAtIHdpbGwgZG8gaW4gdjMuPGRpdj48
ZGl2IGNsYXNzPSJnbWFpbC1hZG0iIHN0eWxlPSJtYXJnaW46NXB4IDBweCI+PGRpdiBpZD0iZ21h
aWwtcV82NyIgY2xhc3M9ImdtYWlsLWFqUiBnbWFpbC1oNCIgc3R5bGU9ImJhY2tncm91bmQtY29s
b3I6cmdiKDIzMiwyMzQsMjM3KTtib3JkZXItd2lkdGg6bWVkaXVtO2JvcmRlci1zdHlsZTpub25l
O2JvcmRlci1jb2xvcjpjdXJyZW50Y29sb3I7Y2xlYXI6Ym90aDtsaW5lLWhlaWdodDo2cHg7b3V0
bGluZTpub25lO3dpZHRoOjI0cHg7Zm9udC1zaXplOjExcHg7Ym9yZGVyLXJhZGl1czo1LjVweCI+
PC9kaXY+PC9kaXY+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCiZndDsgK8KgIMKg
IMKgIMKgZm9yIChyZWcgPSAweDAyOyByZWcgJmx0Oz0gMHgxMDsgcmVnKyspPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtaXBpX2RzaV9kY3Nfd3JpdGVfdmFyX3NlcV9tdWx0aShk
c2lfY3R4LCByZWcsIDB4NDApOzxicj4NClNvIEkgd2FzIGN1cmlvdXMgYWJvdXQgaWYgdGhlICZx
dW90O2ZvciZxdW90OyBsb29wcyBoZWxwZWQgb3V0LiBUaGV5IHNlZW0gdG8uPGJyPg0KPGJyPg0K
T3ZlcmFsbCwgeW91ciBjaGFuZ2UgaW5jcmVhc2VkIHRoZSBzaXplIG9mIHRoZSBkcml2ZXIgYnkg
cXVpdGUgYSBiaXQsPGJyPg0KYnV0IEkgZ3Vlc3MgdGhhdCYjMzk7cyB0aGUgcHJpY2Ugd2UgcGF5
IHNpbmNlICh3aGVuIHdlIHRhbGtlZCBhYm91dCB0aGlzPGJyPg0KaW4gdGhlIHBhc3QpIHBlb3Bs
ZSByZWFsbHkgZGlkbiYjMzk7dCBsaWtlIHRoZSB0YWJsZS1iYXNlZCBhcHByb2FjaC4gT2xkPGJy
Pg0KZHJpdmVyIHZzLiB3aXRoIHlvdXIgY2hhbmdlczo8YnI+DQo8YnI+DQokIC4vc2NyaXB0cy9i
bG9hdC1vLW1ldGVyIHBhbmVsLW5vdmF0ZWstbnQzNjY3MmEtb2xkLmtvPGJyPg0KcGFuZWwtbm92
YXRlay1udDM2NjcyYS1uZXcua288YnI+DQphZGQvcmVtb3ZlOiA5LzMgZ3Jvdy9zaHJpbms6IDIv
NSB1cC9kb3duOiAxMDQzMC8tMTcxMiAoODcxOCk8YnI+DQpGdW5jdGlvbsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2xkwqAgwqAgwqBuZXfC
oCDCoGRlbHRhPGJyPg0KLkx0bXAxwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgMTI5MsKgIMKgIDQ2NTLCoCDCoCszMzYwPGJyPg0KJHjCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAxMzkywqAgwqAgNDc1MsKgIMKgKzMzNjA8YnI+DQp0aWFubWFfZmhkX3ZpZGVvX29uX2luaXRf
McKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLcKgIMKgIDMxNDjCoCDCoCszMTQ4PGJy
Pg0KdGlhbm1hX2ZoZF92aWRlb19vbl9pbml0XzEuZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLcKgIMKgIMKgMjUywqAgwqAgKzI1Mjxicj4NCnRpYW5tYV9maGRfdmlkZW9fb25faW5pdF8y
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtwqAgwqAgwqAxNDTCoCDCoCArMTQ0PGJy
Pg0KdGlhbm1hX2ZoZF92aWRlb19vZmZfaW5pdMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC3CoCDCoCDCoDEyNMKgIMKgICsxMjQ8YnI+DQp0aWFubWFfZmhkX3ZpZGVvX29uX2luaXRf
Mi5kwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtwqAgwqAgwqAgMTDCoCDCoCDCoCsxMDxi
cj4NCnRpYW5tYV9maGRfdmlkZW9fb2ZmX2luaXQuZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC3CoCDCoCDCoCDCoDjCoCDCoCDCoCArODxicj4NCi5MdG1wOMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLcKgIMKgIMKgIMKg
OMKgIMKgIMKgICs4PGJyPg0KLkx0bXA3wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtwqAgwqAgwqAgwqA4wqAgwqAgwqAgKzg8YnI+
DQouTHRtcDbCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoC3CoCDCoCDCoCDCoDjCoCDCoCDCoCArODxicj4NCnRpYW5tYV9maGRfdmlk
ZW9fb2ZmX2NtZHPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA4wqAgwqAgwqAgwqAt
wqAgwqAgwqAgLTg8YnI+DQp0aWFubWFfZmhkX3ZpZGVvX29uX2NtZHNfMsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDEwwqAgwqAgwqAgwqAtwqAgwqAgwqAtMTA8YnI+DQp0aWFubWFfZmhk
X3ZpZGVvX3BhbmVsX2Rlc2PCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDg4wqAgwqAgwqAg
NjTCoCDCoCDCoC0yNDxicj4NCm50MzY2NzJhX3BhbmVsX3VucHJlcGFyZcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgMjQ0wqAgwqAgwqAyMTLCoCDCoCDCoC0zMjxicj4NCm50MzY2NzJh
X3BhbmVsX3ByZXBhcmXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDM0MMKgIMKg
IMKgMjg0wqAgwqAgwqAtNTY8YnI+DQokZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDM1NTXCoCDCoCAzMzMxwqAgwqAgLTIyNDxi
cj4NCnRpYW5tYV9maGRfdmlkZW9fb25fY21kc18xwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA1NjLCoCDCoCDCoCDCoC3CoCDCoCAtNTYyPGJyPg0KLkx0bXAzwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA4MDTCoCDCoCDCoCDCoDjC
oCDCoCAtNzk2PGJyPg0KVG90YWw6IEJlZm9yZT0xMTIwNiwgQWZ0ZXI9MTk5MjQsIGNoZyArNzcu
ODAlPGJyPg0KPGJyPg0KLi4uYnV0IGlmIHdlIGhhZG4mIzM5O3QgZG9uZSB0aGUgJnF1b3Q7Zm9y
JnF1b3Q7IGxvb3BzLCBpdCB3b3VsZCBoYXZlIGJlZW4gbXVjaCB3b3JzZTo8YnI+DQo8YnI+DQpk
aWFuZGVyc0BkaWFuZGVyczp2Ni42ICgoODk1M2FjZjA3N2NmLi4uKSkkIC4vc2NyaXB0cy9ibG9h
dC1vLW1ldGVyPGJyPg0KcGFuZWwtbm92YXRlay1udDM2NjcyYS1vbGQua28gcGFuZWwtbm92YXRl
ay1udDM2NjcyYS1uZXctbm9sb29wcy5rbzxicj4NCmFkZC9yZW1vdmU6IDkvMyBncm93L3Nocmlu
azogNC80IHVwL2Rvd246IDE4MzgwLy0xNDg4ICgxNjg5Mik8YnI+DQpGdW5jdGlvbsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2xkwqAgwqAg
wqBuZXfCoCDCoGRlbHRhPGJyPg0KLkx0bXAxwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTI5MsKgIMKgIDcxNjTCoCDCoCs1ODcyPGJyPg0K
JHjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAxMzkywqAgwqAgNzI2NMKgIMKgKzU4NzI8YnI+DQp0aWFubWFfZmhkX3ZpZGVvX29u
X2luaXRfMcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLcKgIMKgIDU2NjTCoCDCoCs1
NjY0PGJyPg0KdGlhbm1hX2ZoZF92aWRlb19vbl9pbml0XzEuZMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgLcKgIMKgIMKgNTYywqAgwqAgKzU2Mjxicj4NCnRpYW5tYV9maGRfdmlkZW9fb25f
aW5pdF8ywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtwqAgwqAgwqAxNDTCoCDCoCAr
MTQ0PGJyPg0KdGlhbm1hX2ZoZF92aWRlb19vZmZfaW5pdMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIC3CoCDCoCDCoDEyNMKgIMKgICsxMjQ8YnI+DQokZMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDM1NTXCoCDCoCAz
NjQ5wqAgwqAgwqArOTQ8YnI+DQp0aWFubWFfZmhkX3ZpZGVvX29uX2luaXRfMi5kwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAtwqAgwqAgwqAgMTDCoCDCoCDCoCsxMDxicj4NCnRpYW5tYV9m
aGRfdmlkZW9fb2ZmX2luaXQuZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC3CoCDCoCDC
oCDCoDjCoCDCoCDCoCArODxicj4NCi5MdG1wOMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLcKgIMKgIMKgIMKgOMKgIMKgIMKgICs4
PGJyPg0KLkx0bXA3wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAtwqAgwqAgwqAgwqA4wqAgwqAgwqAgKzg8YnI+DQouTHRtcDbCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oC3CoCDCoCDCoCDCoDjCoCDCoCDCoCArODxicj4NCl9fVU5JUVVFX0lEX21vZGluZm9fNDExwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3OcKgIMKgIMKgIDg1wqAgwqAgwqAgKzY8
YnI+DQp0aWFubWFfZmhkX3ZpZGVvX29mZl9jbWRzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgOMKgIMKgIMKgIMKgLcKgIMKgIMKgIC04PGJyPg0KdGlhbm1hX2ZoZF92aWRlb19vbl9j
bWRzXzLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxMMKgIMKgIMKgIMKgLcKgIMKgIMKg
LTEwPGJyPg0KdGlhbm1hX2ZoZF92aWRlb19wYW5lbF9kZXNjwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA4OMKgIMKgIMKgIDY0wqAgwqAgwqAtMjQ8YnI+DQpudDM2NjcyYV9wYW5lbF91bnBy
ZXBhcmXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDI0NMKgIMKgIMKgMjEywqAgwqAg
wqAtMzI8YnI+DQpudDM2NjcyYV9wYW5lbF9wcmVwYXJlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAzNDDCoCDCoCDCoDI4NMKgIMKgIMKgLTU2PGJyPg0KdGlhbm1hX2ZoZF92aWRl
b19vbl9jbWRzXzHCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDU2MsKgIMKgIMKgIMKgLcKg
IMKgIC01NjI8YnI+DQouTHRtcDPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDgwNMKgIMKgIMKgIMKgOMKgIMKgIC03OTY8YnI+DQpUb3Rh
bDogQmVmb3JlPTExMjA2LCBBZnRlcj0yODA5OCwgY2hnICsxNTAuNzQlPGJyPg0KPGJyPg0KLi4u
YW5kIGV2ZW4gdGhlIHNob3J0ZXN0ICZxdW90O2ZvciZxdW90OyBsb29wIHlvdSBhZGRlZCBtYWRl
IGEgZGlmZmVyZW5jZS4gOy0pPGJyPg0KPGJyPg0KU28gSSYjMzk7bSBnb29kIHdpdGggaXQsIHRo
b3VnaCBJJiMzOTtkIHByZWZlciB0aGF0IHlvdSBzZW5kIGEgbmV3IHZlcnNpb24gKGlmPGJyPg0K
cG9zc2libGUpIHNpbmNlIHRoZSAmcXVvdDtvZmZfaW5pdCZxdW90OyByZWFsbHkgYm90aGVycyBt
ZSBmb3Igc29tZSByZWFzb24uIDstUDxicj4NCjxicj4NCkkmIzM5O2xsIGFsc28gbm90ZSB0aGF0
IEkgZGlkIHNvbWUgaGFja3kgdGVzdGluZyB0byBjb25maXJtIHRoYXQgeW91cjxicj4NCiZxdW90
O2ZvciZxdW90OyBsb29wcyBkbyBpbmRlZWQgY3JlYXRlIHRoZSBzYW1lIHNldCBvZiBjb21tYW5k
cyBhcyB3ZSBoYWQgYmVmb3JlPGJyPg0KeW91ciBwYXRjaC48YnI+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PlRoYW5rcyBhIGxvdCBmb3IgdGhlIGRldGFpbGVkIHJldmlldyBhbmQgZm9yIHJ1
bm5pbmcgdGhlIGJsb2F0LW8tbWV0ZXI8YnI+Y29tcGFyaXNvbnMuPGJyPjxicj5ZZWFoLCB0aGUg
Y29kZSBzaXplIGdyb3d0aCBpcyB1bmZvcnR1bmF0ZWx5IGxhcmdlciB0aGFuIEkmIzM5O2QgaG9w
ZWQsIGJ1dDxicj50aGUgbG9vcC1iYXNlZCBjbGVhbnVwIGF0IGxlYXN0IHNlZW1zIHRvIGtlZXAg
aXQgd2l0aGluIHNvbWV0aGluZyBtb3JlPGJyPnJlYXNvbmFibGUuIFRoYW5rcyBhbHNvIGZvciB2
ZXJpZnlpbmcgdGhhdCB0aGUgZ2VuZXJhdGVkIGNvbW1hbmQ8YnI+PGRpdj5zZXF1ZW5jZXMgc3Rp
bGwgbWF0Y2ggdGhlIG9yaWdpbmFsIHRhYmxlcy48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0K
SW4gYW55IGNhc2U6PGJyPg0KPGJyPg0KUmV2aWV3ZWQtYnk6IERvdWdsYXMgQW5kZXJzb24gJmx0
OzxhIGhyZWY9Im1haWx0bzpkaWFuZGVyc0BjaHJvbWl1bS5vcmciIHRhcmdldD0iX2JsYW5rIj5k
aWFuZGVyc0BjaHJvbWl1bS5vcmc8L2E+Jmd0Ozxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48L2Rp
dj4NCg==
--0000000000003f566806526933f4--

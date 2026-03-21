Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905071094462
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 08:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBFC10E265;
	Sat, 21 Mar 2026 08:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R7mFodaQ";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02ABE10E269
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 08:23:18 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-56af30dde0cso582113e0c.2
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 01:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774081398; cv=none;
 d=google.com; s=arc-20240605;
 b=McYFqycZeNxbcDRcicWBjNaypIfni0WBseLEXwvpE6jgltr8JmZcK5V86RmOUSoKxA
 FEVsSoegSlw0GF4UGwZoXGB6aaYAl6YvrKENUsgsWezhlmWOrjUSfyUQVg01mRP8QgbJ
 QSpqS+ib3aOLaneV45GBfBrADEX2gncjfHbKqmNZyG6XCXbaTUB13kvJBKoo5x8yjXRb
 btsshEDmIOaSFjXz3PTTpgtOo806735oeRIgxdyrIUfEA4hZ0/CB7QhwaU7vF3XWW+WM
 hV4AnrHBwtVqZH8gHsxafXL6FWatANaE47cGkOXRSg85eonHydZVnEsSRIzARhurWlqZ
 WPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XCbu8utOzfSKxWf/KKfGOPZf2jQVjk8Ie8gwBnqmka4=;
 fh=oZTc0GPwp8Y4x7J6OkiKb7Ul1IN4Vwh65c84bYYwCb8=;
 b=Jy3MN/QEJt6aq2ty4DvzLHQweuq5ET9NpVTny2xl0IL3FdoGqN6s4A2ZiLL0t6sUlW
 kVjw5C/Id0ia/myFzXuAJSX+AH1Kz2GOCL/GB/p2dreOLmH2bNRgYOOKa5V5rJG58juO
 qj0FKaZKj61XkfXeKyzFvtfOJjj8lbC9bnrjG48sibJBei44SU/4jTd7qCSK5GycQkdK
 nGZZHiZ8kA6A4Y34D1Ccit7K9qwEEPTCXAogHcoFg3k9X7drt0TtuhFJHBWITQmsdbVb
 kAKEHsLqQR0qAD/Bfx5SgqDpdWa0IXXQtuDe5nDGdmo3u57iTedwsNQOXJRDIKHacyoE
 OJnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774081398; x=1774686198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCbu8utOzfSKxWf/KKfGOPZf2jQVjk8Ie8gwBnqmka4=;
 b=R7mFodaQ9XoIg86c9meOCS4kdtHX6WJ/hbqA7KovQSGgr+T4IaeaOejAylPbONq6mO
 neT7CjWbUJXo48ENVKpYeiR6ugahbXw/TkLu8vcpJHKMCN8+kbC5T2MJMtPKaUZN39iW
 WnU8YdATt8+IqQJHU1y4yOuDFAb4j6arh6UCLmptYoo8DyC1xNOn7aixeSwSAYuZ5oc1
 Q/NJFGfsm+U870TTTQzXVBylR9QrvSZWWonwFqxC22F9MBGgMnSPMBt+eqzXTxa9gsqS
 CxKr28fq4SeC65YKRgrSpNAatjWN3vhuBb5vFcbteWllKtJHqntAcEotDZF/wIH4vZhi
 5otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774081398; x=1774686198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCbu8utOzfSKxWf/KKfGOPZf2jQVjk8Ie8gwBnqmka4=;
 b=jAhwaKfZC0tnLC8pQgbpkb6g4UpNXys01WOYNIPR8//sh0QQ3t+UunVztZy3mlMHAf
 PMsIwYT5JG13jXtwItojCEWSP1HT9CNVO1vDRMcVzLLwdV4wpS94lC4R7Duif+yaK0u9
 EnphhYAKGu7KJJgV+8GvUH37mSEuSeJe9AeNVZGN+ZyP24Q8rAP7B4jK6Nguob3G7Tw2
 +9CnscGzndxJBE3jY8yNxOoKRASqOwiEOmJXI2+JNApjIznVnv4HbmFpuYSjN/nrFFRt
 ZmfqL2bQCH96GFASwSi1FY5AjQNnuxJpZ6nAtaLKfxMRw1HpmbZzD3YD/WE4YgKbbKhV
 uI/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFu9ErbbS3PvJN+eu1G/3Is7XJov8m7oSALszqCJq8Fa1+wp31lbg82xVooPvm8KaKaeAMDX7bcNA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5ItA4FYGJyxxpW0GTOjPoaFsG06iCrlAE2nCtU2qS8+zP1aFE
 Tmi1Pwrb+aD1fRd2t2kDxc7OLx2k1b94GILfTgkuFT6rLZMg/JB4CpBHd8A5GBlCrt1FAxFsXUq
 yzx5NnFmtBRMuxUxiUMp6DVDc6LZGkWQ=
X-Gm-Gg: ATEYQzzDLuh3H+67fL7/u4wWQLBcz0AHw4UrRii9a/nJA7n2mjBcSuFV7+WBtV1wbh3
 Csm89cSrk9iaUGML80lcxI1W8eR3lvk8clP/o+nllDDs+XD1lWzkvhCFAVbjeEXXxKB/ByTgM5w
 xq+QrcOjibZcBPX65lffnDVlcwK7nLkNuUzMHtI1yK/s8/+z013M4keevfC6vmBRS83rwDR90mu
 BkYgAYEo8SMyIgweJIpagKETCMrWalmvrSKYok06+frf5jGhaaku3tlhtIfQrvsttmfURubmTm1
 GOUOx/c8C0KYD6I=
X-Received: by 2002:a05:6102:8004:b0:602:97a8:10c0 with SMTP id
 ada2fe7eead31-602aeac9488mr2779671137.1.1774081397529; Sat, 21 Mar 2026
 01:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com>
 <X2fV9mpVHV6Qk8-ImS7vxqDQXFt4K85jPKJWnxVono324hHaRh7x13f2HYM4CKNK-UDqrmP8Jz79-oVklw8vLBfaxPbVuQq4FBfblu27R9s=@pm.me>
 <CAH2e8h5tns-sXZ3-cvBmeAgbkNT1sG0kxNeaUGZnHoFEYh-Tjg@mail.gmail.com>
 <ZPf83Rxo54mgr4un9o9CNu9rXp4-8cQ8jkYIfHZODIzbJXEMISRS2PZKYqDCijOAq1N2eq0Wnt-kS0ys9KV0uB5TawUQLNjNcSzfQeUWe10=@pm.me>
 <CAH2e8h6wvab7tvZRUt0xS=SA5+hnKopQKCayT0JEgWL9_e3uTQ@mail.gmail.com>
 <z5Q2MMTkjlFG1ye2Vv0uZrEyVqazEnPeBWDmYwlvpZKK1m5tRSfP94gZNEUbec9qKSiaUQpzyqveE8ehad3JkL69HRKnHMSKJUhOm7mP1nE=@pm.me>
In-Reply-To: <z5Q2MMTkjlFG1ye2Vv0uZrEyVqazEnPeBWDmYwlvpZKK1m5tRSfP94gZNEUbec9qKSiaUQpzyqveE8ehad3JkL69HRKnHMSKJUhOm7mP1nE=@pm.me>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sat, 21 Mar 2026 16:22:50 +0800
X-Gm-Features: AaiRm52jjXvDxakeU60nDVdaapYhdmmlSmf31ADk9cKh0mkKT4lyAI6BNcV7ToI
Message-ID: <CAH2e8h7DaS428LcB47+2dZh_pjkhvUU2k5riS1a57R_GNcxOTw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, jeffrey.l.hugo@gmail.com, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Marek <jonathan@marek.ca>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>
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

On Sat, Mar 21, 2026 at 3:13=E2=80=AFAM Alexander Koskovich <akoskovich@pm.=
me> wrote:
>
>
> On Friday, March 20th, 2026 at 9:36 AM, Pengyu Luo <mitltlatltl@gmail.com=
> wrote:
>
> > On Fri, Mar 20, 2026 at 9:18=E2=80=AFPM Alexander Koskovich <akoskovich=
@pm.me> wrote:
> > >
> > > On Friday, March 20th, 2026 at 8:20 AM, Pengyu Luo <mitltlatltl@gmail=
.com> wrote:
> > >
> > > > On Fri, Mar 20, 2026 at 8:14=E2=80=AFPM Alexander Koskovich <akosko=
vich@pm.me> wrote:
> > > > >
> > > > > On Friday, March 20th, 2026 at 8:08 AM, Pengyu Luo <mitltlatltl@g=
mail.com> wrote:
> > > > >
> > > > > > On Fri, Mar 20, 2026 at 4:17=E2=80=AFPM Alexander Koskovich <ak=
oskovich@pm.me> wrote:
> > > > > > > >
> > > > > > > > On Friday, March 20th, 2026 at 3:36 AM, Dmitry Baryshkov <d=
mitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > >
> > > > > > > > > On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Kosko=
vich wrote:
> > > > > > > > > > On Friday, March 20th, 2026 at 2:50 AM, Alexander Kosko=
vich <akoskovich@pm.me> wrote:
> > > > > > > > > >
> > > > > > > > > > > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Barysh=
kov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander=
 Koskovich wrote:
> > > > > > > > > > > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan=
 Marek <jonathan@marek.ca> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jon=
athan Marek wrote:
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> That's not how it works. INTF (which feeds D=
SI) is after DSC compression.
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> INTF timings are always in RGB888 (24-bit) u=
nits. Ignoring widebus details,
> > > > > > > > > > > > > > >> the INTF timing should match what is program=
med on the DSI side (hdisplay,
> > > > > > > > > > > > > > >> which is calculated as bytes per line / 3).
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> (fwiw, the current "timing->width =3D ..." c=
alculation here blames to me, but
> > > > > > > > > > > > > > >> what I wrote originally was just "timing->wi=
dth =3D timing->width / 3" with a
> > > > > > > > > > > > > > >> comment about being incomplete.)
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > > Okay. After reading the docs (sorry, it took =
a while).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > - When widebus is not enabled, the transfer i=
s always 24 bit of
> > > > > > > > > > > > > > >    compressed data. Thus if it is not in play=
, pclk and timing->width
> > > > > > > > > > > > > > >    should be scaled by source_pixel_depth / c=
ompression_ratio / 24. In
> > > > > > > > > > > > > > >    case of the code it is 'drm_dsc_get_bpp_in=
t(dsc) / 24'.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >    For RGB101010 / 8bpp DSC this should resul=
t in the PCLK being lowered
> > > > > > > > > > > > > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4=
+), the transfer takes
> > > > > > > > > > > > > > >    more than 24 bits. In this case the PCLK a=
nd timing->width should be
> > > > > > > > > > > > > > >    scaled exactly by the DSC compression rati=
o, which is
> > > > > > > > > > > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits=
_per_component).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So, this piece of code needs to be adjusted t=
o check for the widebus
> > > > > > > > > > > > > > > being enabled or not.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The widebus adjustment on the MDP/INTF side is =
already in
> > > > > > > > > > > > > > dpu_hw_intf_setup_timing_engine: the "data widt=
h" is divided by 2 for
> > > > > > > > > > > > > > 48-bit widebus instead of 24-bit. there shouldn=
't be any other
> > > > > > > > > > > > > > adjustment (downstream doesn't have any other a=
djustment).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > a relevant downstream comment: "In DATABUS-WIDE=
N mode, MDP always sends
> > > > > > > > > > > > > > out 48-bit compressed data per pclk and on aver=
age, DSI consumes an
> > > > > > > > > > > > > > amount of compressed data equivalent to the unc=
ompressed pixel depth per
> > > > > > > > > > > > > > pclk."
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Based on that comment, this patch is correct, a=
nd the
> > > > > > > > > > > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per=
_component)' adjustment
> > > > > > > > > > > > > > only applies to DSI.
> > > > > > > > > > > > >
> > > > > > > > > > > > > If I keep the INTF side at /24 and change the DSI=
 side to:
> > > > > > > > > > > > >
> > > > > > > > > > > > > if (wide_bus)
> > > > > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisp=
lay * drm_dsc_get_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > > > > > > > > > > else
> > > > > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisp=
lay * drm_dsc_get_bpp_int(dsc), 24);
> > > > > > > > > > > >
> > > > > > > > > > > > Please check the actual fps (I'm usually using a vb=
lank-synced GL, e.g.
> > > > > > > > > > > > kmscube).
> > > > > > > > > > > >
> > > > > > > > > > > > At least this matches my expectations.
> > > > > > > > > > >
> > > > > > > > > > > Hmmm with kmscube I am getting 120FPS with 24 and 100=
FPS with 30. So I guess that's a no go
> > > > > > > > > >
> > > > > > > > > > Although it was using dsc->bits_per_component * 3 regar=
dless before for
> > > > > > > > > > dsi_adjust_pclk_for_compression so I guess that's what =
Jonathan was
> > > > > > > > > > referring to earlier...
> > > > > > > > >
> > > > > > > > > Do you have any of the patches by Marijn or Pengyu?
> > > > > > > > >
> > > > > > > > > - https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-=
regresses-again-v1-1-6a422141eeea@somainline.org/
> > > > > > > > >
> > > > > > > > > - https://lore.kernel.org/linux-arm-msm/20260307111250.10=
5772-1-mitltlatltl@gmail.com/
> > > > > > > >
> > > > > > > > Nope, I can test with them though if you'd like
> > > > > > >
> > > > > > > Tested the following 3 patches on top of this series:
> > > > > > > drm/msm/dsi: fix hdisplay calculation when programming dsi re=
gisters
> > > > > > > drm/msm/dsi: fix bits_per_pclk
> > > > > > > drm/msm/dsi: fix hdisplay calculation for CMD mode panel
> > > > > > >
> > > > > > > Getting constant FIFO errors with them applied:
> > > > > > > [   64.851635] dsi_err_worker: status=3D4
> > > > > > > [   64.851692] dsi_err_worker: status=3D4
> > > > > > > [   64.851730] dsi_err_worker: status=3D4
> > > > > > > [   64.851766] dsi_err_worker: status=3D4
> > > > > > > [   64.851802] dsi_err_worker: status=3D4
> > > > > > > [   64.851837] dsi_err_worker: status=3D4
> > > > > > > [   64.851903] dsi_err_worker: status=3D4
> > > > > > > [   64.851940] dsi_err_worker: status=3D4
> > > > > > > [   64.851976] dsi_err_worker: status=3D4
> > > > > > > [   64.852011] dsi_err_worker: status=3D4
> > > > > >
> > > > > > Personally, I use
> > > > > > timing->width =3D DIV_ROUND_UP(timing->width * drm_dsc_get_bpp_=
int(dsc),
> > > > > >                          dsc->bits_per_component * 3);
> > > > > >
> > > > > > DIV_ROUND_UP is magic for me. If not, I got status=3D4 too.
> > > > > >
> > > > > > This works for 8-bit dst bpc with 10-bit src bpc.
> > > > >
> > > > > Did a quick test with that (plus the 3 changes listed above), sti=
ll getting the
> > > > > FIFO errors and no display.
> > > > >
> > > > > Are you using RGB101010?
> > > > >
> > > >
> > > > RGB101010(dst bpp) downstream, my panel supports RGB101010, and I c=
an
> > > > use RGB888 for it too.
> > > > I am testing rgb101010.
> > > > BTW, have you dumped registers? compared with downstream.
> > > >
> > > > I hardcode
> > > > display_data_hctl =3D (0xbe << 16) | hsync_data_start_x;
> > > > in dpu_hw_intf.c
> > > > downstream uses 0xbe for data_width
> > >
> > > Can you try this series with ac47870fd ("drm/msm/dsi: fix hdisplay ca=
lculation when programming dsi registers") reverted and with the following =
2 changes?
> > >
> > > https://github.com/AKoskovich/linux/commit/af24b0e2ee212153953dfee040=
da5cc077567363
> > > https://github.com/AKoskovich/linux/commit/e334675c0caf47956a838e2eaf=
da22fb689a967d
> > >
> >
> > I don't mind testing it, but some parameters are obviously wrong for me=
.
>
> Did some additional testing, reverted the change in dpu_encoder_phys_vid.=
c and
> picked only "drm/msm/dsi: fix hdisplay calculation when programming dsi
> registers". This results in the FIFO errors. But then when I mirror data_=
width
> calculation I see downstream, display then works.
>
> Can you try with just this (ignore other change I suggested):
> https://github.com/AKoskovich/linux/commit/af24b0e2ee212153953dfee040da5c=
c077567363
>
> That should make the display_data_hctl calculation correct so you don't n=
eed to
> hardcode (I think)
>

Yes! it will give the right data_width.

It seems when the compressed ratio is 3:1, compressed_width =3D
hdisplay/3, then halved because of the wide bus.
That makes data_width =3D DIV_ROUND_UP(p->width, 2); work. But this will
break when the compressed ratio is not 3:1, like bpp=3D8 with bpc=3D10.

Best wishes,
Pengyu

> >
> > int new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(=
dsc),
> >             dsc->bits_per_component * 3);
> >
> > This gives the correct clkrate with fixes([1]).
> >
> > fixed ac47870fd([2]) will give me the right hdisplay register value
> > @0xae94024 (I compared with downstream)
> >
> > [1]: https://gitlab.freedesktop.org/drm/msm/-/commit/e4eb11b34d6c84f398=
d8f08d7cb4d6c38e739dd2
> > [2]: https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitl=
tlatltl@gmail.com/
> >
> > BTW, I can only do 8-bit dst and 10-bit src test, 10-bit dst and
> > 10-bit src gave me
> >
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_mode_set: set mode:
> > "1904x3040": 120 915552 1904 2180 2212 2244 3040 3066 3070 3400 0x48
> >  0x0
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_pre_enable: id=3D0
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: id=3D0
> > Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
> > Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
> > Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D10=
8120000
> > Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D10=
8120000
> > Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Set clk rates:
> > pclk=3D172992000, byteclk=3D108120000
> > Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Failed to set
> > rate pixel clk, -22
> > Mar 20 20:46:00 qcom kernel: msm_dsi_host_power_on: failed to enable
> > link clocks. ret=3D-22
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: power on host 0
> > failed, -22
> > Mar 20 20:46:00 qcom kernel: msm_dsi ae94000.dsi: Power on failed: -22
> > Mar 20 20:46:00 qcom kernel: bias enabled
> > Mar 20 20:46:00 qcom kernel: panel-nt36536 ae94000.dsi.0: sending dcs
> > data ff 20 failed: -22
> > Mar 20 20:46:00 qcom kernel: panel-nt36536 ae94000.dsi.0: Failed to
> > initialize panel: -22
> > Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:471] enc3=
3 intf2
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:292] enc33 intf2
> > enabling mode:
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:304] enc33 intf2
> > split_role 2, halve horizontal 952 1122
> > 1090 1106 0
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:315] enc33 intf2
> > fmt_fourcc 0x34324752
> > Mar 20 20:46:00 qcom kernel:
> > [drm:programmable_fetch_get_num_lines:202] enc33 intf2 prog fetch is
> > not needed, large vbp+vsw
> > Mar 20 20:46:00 qcom kernel:
> > [drm:programmable_fetch_get_num_lines:217] enc33 intf2 v_front_porch
> > 26 v_back_porch 330 vsync_pulse_wi
> > dth 4
> > Mar 20 20:46:00 qcom kernel:
> > [drm:programmable_fetch_get_num_lines:221] enc33 intf2 wc_lines 24
> > needed_vfp_lines 4294966986 actual_v
> > fp_lines 0
> > Mar 20 20:46:00 qcom kernel: [drm:programmable_fetch_config:261] enc33
> > intf2 vfp_fetch_lines 0 vfp_fetch_start_vsync_counter 0
> > Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:507]
> > enc33 intf2 update pending flush ctl 0 intf 3
> > Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:471] enc3=
3 intf1
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:292] enc33 intf1
> > enabling mode:
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:304] enc33 intf1
> > split_role 1, halve horizontal 952 1122
> > 1090 1106 0
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:315] enc33 intf1
> > fmt_fourcc 0x34324752
> >
> >
> > Best wishes,
> > Pengyu
> >
> > >
> > > >
> > > > Best wishes,
> > > > Pengyu
> > > > > >
> > > > > > Best wishes,
> > > > > > Pengyu
> > > > > >
> > > > >
> > > > > Thanks,
> > > > > Alex
> > > >
> > > >
> >
> >

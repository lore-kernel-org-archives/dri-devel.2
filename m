Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E22606A32D
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbxWFEl3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F93C10E07B;
	Sat,  7 Nov 2026 13:57:34 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87AB310E07B
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:57:28 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-33fb4680717so3129504eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 05:57:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794059848; cv=none;
 d=google.com; s=arc-20260327;
 b=apgoW5CjzyGoMjjofGwbSmYhFKYfpAX/74vE/hscLCxmHTxVaaARarVPEteFkXR1sj
 EryQ0qn6kiuZt2BvKdh/8qZsLvimKZu6cvNevC0DcYo54qsHXy9B4jVP5JfDbv2DLS7F
 GAPCslO8zoC6YDAhMlTJAd7rrdlybN3T/hzkHXHb1Nm/o/rH/4j2Gha1BE0DbRKaYLu4
 kx8oJrKVMCi0AwHXrIyv02yIc+DmYwAtFK6a7B1dbumrXaVAMPy5/7pfhvIPKqnrOL91
 Gk/d8qzcXulqe2CRsZJmcRcRbAoa7Du2ZCp71S1MbJAZbOv4SNp6rMJWmlWVauOcqw+R
 ecFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NSA+r/b6fLNfVPbuiPSfEtMn8tpkLL7ESyzDno+8izU=;
 fh=qIMMVsoBWjR0J/8vb8a7AqF58LaT6xBaATzm4gJp3HY=;
 b=cg7+qrkrCGI6LH7776OvBBGCFbz7fFdiarJEaV4QN2nj3OCrQGiTK8VG2/gq0J1G0y
 +1uxqBhZrplA/G9CJZr5avGM7POOYyzI+hPw/jv01LbGGFih98P3Oez8RwQMqfB/87Df
 O20oqB55D8TLREsSM4XREpRLBC7msWgdWH6vGfbly0yPwIzSwmKXBHt7AUiYE51PmwyJ
 CVAjLXQDDeTO6sf8TfvFgQaVEbKNLOepNPjZ2a9seCcpqkCp91akNr2/U+Jsvy5OEAtC
 0oORDq5XQfb0kNty3B+TW5yHoxL1fuLYHZGrmC20eD0dK+W3YwztICUlWcu2JoSYLp/o
 Ev8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794059848; x=1794664648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NSA+r/b6fLNfVPbuiPSfEtMn8tpkLL7ESyzDno+8izU=;
 b=cbxWFEl3AnAqVID/Nx6Qz+xOb7PXgy7qPXy0f68plGW/rUi0Rd1u4YJLc2MJ1GuScX
 T2ePLOBmiPOzCxw9oNwk66StffUnG5OB8qfh8W96APvI/u01vXbM4COU361dBYlffnb2
 jQiD1Sg/0pePK22qh/llxCbwZla/xFxgVnCf3q1LjT33lEhYv9g4A62m6f2jDBcWM++f
 RQcXRSEf+qEYOSm3d8GLtsyhfr/4Bt71ObPzK5ekzKfBcBDMPzw78vSKQI/lcOznDJDY
 Geno6mY853o2N08dwCkkhsFFVylhaZCAssZA6xQQj9R5695EjuhkDlKTMTMb/kkCZqde
 2EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794059848; x=1794664648;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NSA+r/b6fLNfVPbuiPSfEtMn8tpkLL7ESyzDno+8izU=;
 b=x7F3Y5ot4mvUJVC3niZctUh5+/gofvPizm59sZCmD7cEJSCNNanX2L5dIl4Fxc9bJw
 9rZ8wqxQxLo3cXmqn+Pcm1a0LCdc7wG7QFW43vCRIgDBDKJAMQAjA6j7tSkoYJfjNGEm
 pR17YEtRGnPXt9Lq/qUHzwL9oYvbWK6d/fHOp9NZwyebFnVhmSFKWfgw5BpA1o5YtLvL
 ypQPlekFghikEmTeIoxj8fq6/5eMumfkFyVaW9MPIjrqQV38iZV+LKvhKE3m6U3nq6QO
 WWnrMrHZY9Zrx2H+GA0z+O51FwYzIqfb5MIPMv1bQtIZdiQ0S1PvjimIFimMYwQoQt5t
 aw/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnpdd7W4YuRA0TXtH8DjokBrLTMq0/VjFd3RPzMFRT+E9r0w1nIIGe3sPXF5N17r9VRShJe/mnie8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+AlOS4h8gQptqmgN9gB5KsYjp/+8BJWkDOKa8brCr+ybfFtXrW
 WdVYw9Ln5tmUVnNk2h6I/XKCAvJPSbFT7vr4UuPpH1HzEti6NIxUMcDtIkkdf7T02s4qYMuCqEH
 AlnBZwtJTBQJIeK7iADbEVoKzCtSx5tE=
X-Gm-Gg: AYBFou0vBsXgRwysbl0xT4kO7PxCSQgilLxkoAjq9+vXq2vHmehzKniBdaaYFm2W1NT
 SLaP3MEsPdo7GA0ldmAOMPl09ZE6c68yS8r77cw9X03wm6BUMywgi4XMzmNKdKaTBzhXXxCYHQF
 iKqcOmNCL4mT5fPCCeTBEBkBjYlN30glKQgrft2EOX6YjHILC5JksAimDlFQ30WRLPJIndXW+yW
 20WVCax6t/BNfLHGBHA/QK4YxpMVIO1G4XZ1Myo9/WHjGiGJblrnXYs67T2ATKgZbNkNz5n9iRd
 u73hdi+FTebc7HhM0R8wLBo9A/1UDB22+7OmC51RSCVaWwdXIIhCXEKlq7HD0WGjnMPtIfsIXUU
 Wrm02vV/t+z49QlCWNeCSDMw15iwkZbVs2RynU76F5sjgRSXCg0/azth/74Iu4pBCOOq/s7g6mO
 Lj215Z9r0SnKcj56sqAFVKYgW1qdE1DXcMbcrx2LTkU2/Vtz3aSRo=
X-Received: by 2002:a05:7301:5044:b0:36d:4570:a32d with SMTP id
 5a478bee46e88-36f727d41ecmr8063214eec.2.1794059847565; Sat, 07 Nov 2026
 05:57:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-3-clamor95@gmail.com>
 <au3TcHXFt5Yhs_V8@orome>
 <CAPVz0n0ngn4nf9uTOsM6OKB9jgTnJN1FrPp0UyeHwuAwoL5_tA@mail.gmail.com>
 <au3w5Euhy-DyY5qQ@orome>
In-Reply-To: <au3w5Euhy-DyY5qQ@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Nov 2026 15:57:16 +0200
X-Gm-Features: AclHuK-rhOpUYmipYorAqU7OgtCn1M9P26bKqsgHA68BQBZ6wF3WXusKjqauthE
Message-ID: <CAPVz0n3JghP_XxiS22htU_uydhtzrTPKHJsJ4uR2iF12ogsXfw@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] drm/panel: Convert Hitachi TX10D07VM0BAA to use
 MIPI DBI bus
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:26=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Nov 06, 2026 at 04:00:45PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
5:19 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, Nov 05, 2026 at 04:05:02PM +0200, Svyatoslav Ryhel wrote:
> > > > Switch from a generic platform driver to a dedicated MIPI DBI drive=
r.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 167 ++++++++------=
----
> > > >  1 file changed, 78 insertions(+), 89 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/=
drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > > index 83c2af1be9755..d5d7ba2096608 100644
> > > > --- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > > +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <video/mipi_display.h>
> > > >
> > > >  #include <drm/drm_mipi_dbi.h>
> > > > +#include <drm/drm_mipi_dbi_bus.h>
> > > >  #include <drm/drm_modes.h>
> > > >  #include <drm/drm_of.h>
> > > >  #include <drm/drm_panel.h>
> > > > @@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_t=
x10d07vm0baa_supplies[] =3D {
> > > >
> > > >  struct hitachi_tx10d07vm0baa {
> > > >       struct drm_panel panel;
> > > > -     struct mipi_dbi *dbi;
> > > > +     struct mipi_dbi_device *dbi;
> > >
> > > It's somewhat difficult to exactly see the difference between mipi_db=
i
> > > and mipi_dbi_device. Maybe that should be explained better in the cov=
er
> > > letter of patch 1? Or the documentation added in patch1.
> > >
> >
> > It is already documented in detail in the drm_mipi_dbi.h
>
> That documents what the struct mipi_dbi is. I'm asking about the
> difference between mipi_dbi_device and mipi_dbi and mipi_dbi_dev. It's
> not clear to me why we have both mipi_dbi_device *and* mipi_dbi_dev,
> especially since they're very similarly named. People are going to
> easily confuse where to use which.
>

May anyone among DRM maintainers clarify if this explanation is
required? If yes, please point what and where I should add. Thank you.

> Thierry

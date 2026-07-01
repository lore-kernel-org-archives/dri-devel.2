Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEA2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E69610E30B;
	Wed,  1 Jul 2026 07:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=139.com header.i=@139.com header.b="OkEdim73";
	dkim-atps=neutral
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA5A10ED6B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 01:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=139.com; s=dkim; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=OkEdim73gipXr02xQpiakZCFh4LjJwk6doPC4VZHil8eP/5wGaq/0y+nt2JTdUKjJ4/rrINkyiHRD
 Zfg11cQhGqBCyFtNX8S3c3RekxAjFIddrAU6lHi0H0r5ylstck/NE+TSf5ctx/pwIEziWCPEwqPzFv
 3TS9wqK/cMiQ5AS0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from [IPv6:240e:404:b730:7fdc:9e83:47b8:5acf:73d0]
 (unknown[240E:404:B730:7FDC:9E83:47B8:5ACF:73D0])
 by rmsmtp-lg-appmail-36-12050 (RichMail) with SMTP id 2f126a44714f608-01618;
 Wed, 01 Jul 2026 09:45:54 +0800 (CST)
X-RM-TRANSID: 2f126a44714f608-01618
Message-ID: <792c4a4e145a7aaa289b6d3bc8bb8c6996591152.camel@139.com>
Subject: Re: [PATCH] drm/amd/display:Check
 dp_128b_132b_supported_link_rates.raw before link_rate setting
From: Jackie Dong <xy-jackie@139.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Wed, 01 Jul 2026 09:45:50 +0800
In-Reply-To: <20260630151147.CB9631F000E9@smtp.kernel.org>
References: <20260630145955.13994-1-xy-jackie@139.com>
 <20260630151147.CB9631F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

On Tue, 2026-06-30 at 15:11 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] Checking `dp_128b_132b_supported_link_rates.raw` before it
> is read from the DPCD register completely disables DP 2.0 UHBR
> support.
> --
>=20
> commit 11d06153280ec5dae6682a402606818b4f84b79d
> Author: Jackie Dong <xy-jackie@139.com>
>=20
> drm/amd/display:Check dp_128b_132b_supported_link_rates.raw before
> link_rate setting
>=20
> This patch modifies the DP 128b/132b capability check to also verify
> that
> dp_128b_132b_supported_link_rates.raw is non-zero before attempting
> to read
> and parse the specific UHBR link rates.
>=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.
> > c
> > b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.
> > c
> > ---
> > a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.
> > c
> > +++
> > b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.
> > c
> > @@ -2079,7 +2079,8 @@ static bool retrieve_link_cap(struct dc_link
> > *link)
> > =C2=A0	if (!dpcd_read_sink_ext_caps(link))
> > =C2=A0		link->dpcd_sink_ext_caps.raw =3D 0;
> > =C2=A0
> > -	if (link-
> > >dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
> > +	if (link-
> > >dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED &&
> > +			link-
> > >dpcd_caps.dp_128b_132b_supported_link_rates.raw) {
>=20
> [Severity: High]
> Will this change completely disable DP 2.0 UHBR support?=20
>=20
> In retrieve_link_cap() in
> drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c,
> dp_128b_132b_supported_link_rates.raw is now checked before it is
> actually=20
> read from the DPCD register. Since the dc_link struct is zero-
> initialized and
> the read hasn't occurred yet, won't this raw value always evaluate to
> 0 upon
> connection of any DP 2.0 monitor?=20
>=20
> This would cause the if condition to always fail, bypassing the
> actual read
> block below and permanently preventing UHBR feature detection.
>=20
Hi Sashiko,
 I have verified it as below. To add
dp_128b_132b_supported_link_rates.raw  as a new judgment doesn's impact
the value of dp_128b_132b_supported_link_rates.raw. If the monitor can
support UHBR and it can be into feature detection and assigned the
right UHBR rate.

root@yoga-Yoga-Pro-7-15ASH11:/media/yoga/Data/git/linux-502d801f0ab03-
20260622# grep -B23 "Invalid RX 128b_132b_supported_link_rates"
drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
=20
	//if (link-
>dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
	link->dpcd_caps.dp_128b_132b_supported_link_rates.raw =3D 0x10;
	pr_info("Jackie %x is SUPPORTED, %x: RX
128b_132b_supported_link_rates.raw\n", link-
>dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED, link-
>dpcd_caps.dp_128b_132b_supported_link_rates.raw) ;
	//pr_info("Jackie  %x: RX
128b_132b_supported_link_rates.raw\n", link-
>dpcd_caps.dp_128b_132b_supported_link_rates.raw) ;
	//pr_info("Jackie RX 128b_132b_supported_link_rates.raw\n") ;
	if ( (link-
>dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) && (link-
>dpcd_caps.dp_128b_132b_supported_link_rates.raw) ) {
		DC_LOG_DP2("128b/132b encoding is supported at link
%d", link->link_index);
=20
		/* Read 128b/132b suppoerted link rates */
		core_link_read_dpcd(link,
				DP_128B132B_SUPPORTED_LINK_RATES,
&link->dpcd_caps.dp_128b_132b_supported_link_rates.raw,
				sizeof(link-
>dpcd_caps.dp_128b_132b_supported_link_rates.raw));
		if (link-
>dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR20) {
			pr_info("Jackie RX
128b_132b_supported_link_rates is UHBR20\n") ;
			link->reported_link_cap.link_rate =3D
LINK_RATE_UHBR20;
		} else if (link-
>dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR13_5)
			link->reported_link_cap.link_rate =3D
LINK_RATE_UHBR13_5;
		else if (link-
>dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR10)
			link->reported_link_cap.link_rate =3D
LINK_RATE_UHBR10;
		else
			//link->reported_link_cap.link_rate =3D
LINK_RATE_UHBR10;//Jackie Add
			dm_error("%s: Invalid RX
128b_132b_supported_link_rates\n", __func__);
root@yoga-Yoga-Pro-7-15ASH11:/media/yoga/Data/git/linux-502d801f0ab03-
20260622# dmesg |grep -i "fail\|error\|Jackie"
[    0.025954] KHO: Failed to reserve lowmem scratch buffer
[    0.025956] KHO: Failed to reserve scratch area, disabling kexec
handover
[    1.731523] RAS: Correctable Errors collector initialized.
[    7.629667] Jackie 1 is SUPPORTED, 10: RX
128b_132b_supported_link_rates.raw
[    7.630067] [drm:retrieve_link_cap [amdgpu]] *ERROR*
retrieve_link_cap: Invalid RX 128b_132b_supported_link_rates

Above is my verified source code and test result, FYR.

Thanks for your comments.

> > =C2=A0		DC_LOG_DP2("128b/132b encoding is supported at
> > link %d", link->link_index);
> > =C2=A0
> > =C2=A0		/* Read 128b/132b suppoerted link rates */
> > =C2=A0		core_link_read_dpcd(link,
> > =C2=A0				DP_128B132B_SUPPORTED_LINK_RATES,
> > =C2=A0				&link-
> > >dpcd_caps.dp_128b_132b_supported_link_rates.raw,
>=20



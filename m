Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7812C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3617810E673;
	Mon, 31 Aug 2026 07:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=sarx-technology.com header.i=narek@sarx-technology.com header.b="IryDQvY0";
	dkim-atps=neutral
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B32A10E4E6;
 Fri, 28 Aug 2026 19:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787945647; cv=none; d=zohomail.eu; s=zohoarc; 
 b=Prl3KqvUe94hPQhFMyZR2ohzNlRY+NMKEet4EaPRXqXJzbAIui5xCHfHGFebOFCcFigdPlq4s0ibEDCNlNZJ+9iZNzV9akDiJbE/iawoE4UBZ9z37nqZLYN5H1u8kK3p8g2mAfRwHW2f/Erp4eKoYdS3u7/PgKMXqkjYyo4eTaM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1787945647;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HuoqYonIsPZolvOKXDRvu4HreYMdzphwL4wr0PNcGs4=; 
 b=XuuHJfdZHw3wTD5Q0K0+A0KEIDwTItXPKp8GQz8XotvA90ZjcZ0gALA1e5A5ZnLDjdwOI4UENFNYM70YkMMr3kR92r27W4bPndMzaqfafuyuTISY3rYyAIdI1H4YKp8O467+xZJSJgxRFAc9jJZDa3QJAG6hgNwfMstF5risGxc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=sarx-technology.com;
 spf=pass  smtp.mailfrom=narek@sarx-technology.com;
 dmarc=pass header.from=<narek@sarx-technology.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787945647; 
 s=zoho; d=sarx-technology.com; i=narek@sarx-technology.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-Id:Message-Id:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Reply-To;
 bh=HuoqYonIsPZolvOKXDRvu4HreYMdzphwL4wr0PNcGs4=;
 b=IryDQvY0I6+5YWWr9ehh3k42GibBNNksES+M/FwMCWu9P+c4N6Fot5NWyFkkS2Pl
 GxLquz0/SFT5TZpFWqjD4my3Dmvnb0StYzqNHv/CbFENU2I3blpnA3u1ow/VouwyZ0K
 NMlYEHNphPfMHTDPYUjTwZiGAmuDuI8MALTt26SM=
Received: from mail.zoho.eu by mx.zoho.eu
 with SMTP id 1787945647079278.54520443696674;
 Fri, 28 Aug 2026 21:34:07 +0200 (CEST)
Received: from mail.zoho.eu by mx.zoho.eu
 with SMTP id 1787945614973839.9586840032872;
 Fri, 28 Aug 2026 21:33:34 +0200 (CEST)
Date: Fri, 28 Aug 2026 20:33:34 +0100
From: Narek Sarkissian <narek@sarx-technology.com>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>
Cc: "Mario Limonciello" <superm1@kernel.org>, "Alex Hung" <alex.hung@amd.com>,
 "Alexander Deucher" <alexander.deucher@amd.com>,
 "amd-gfx" <amd-gfx@lists.freedesktop.org>,
 "dri-devel" <dri-devel@lists.freedesktop.org>,
 "harry.wentland" <harry.wentland@amd.com>,
 "kernel-dev" <kernel-dev@igalia.com>,
 "Limonciello,  Mario" <mario.limonciello@amd.com>,
 "Melissa Wen" <mwen@igalia.com>, "sunpeng.li" <sunpeng.li@amd.com>
Message-Id: <1a049dcfe50.2ad3d36e1436838.6779838858967113270@sarx-technology.com>
In-Reply-To: <47be5869-69c3-4066-bcc2-738b838219fc@app.fastmail.com>
References: <fc3f474b-92bd-46b3-919a-dec8ea105b86@kernel.org>
 <20260828190727.58724-1-narek@sarx-technology.com>
 <47be5869-69c3-4066-bcc2-738b838219fc@app.fastmail.com>
Subject: Re: [PATCH v8 5/5] drm/amd/display: Fetch the EDID from _DDC if
 available for eDP
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_4443178_633772278.1787945614928"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

------=_Part_4443178_633772278.1787945614928
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Mark,



> I think this is working as designed.

>

> I'll try to find our internal ticket with the details (my memory is a

> bit rusty and this is a few years old now), but as I recall they saw

> issues with Windows testing with 90Hz and so limited the panel to

> 60Hz - using the BIOS EDID to do this. Linux is just following the

> 'manufacturer recommendation'.

>

> If you're not seeing issues, then overriding it to use the panel

> EDID is fine, but just be aware that the 90Hz did not pass Lenovo QA.



Thanks for the context, that's useful to know, and no, I'm not seeing

any issues running at 90Hz so far.



The reason I wanted to flag it rather than just quietly carry the

override locally: this same laptop ran 90Hz without any problems for

about four years across several Ubuntu-based distros (XFCE and KDE

sessions) on older kernels. It was only after switching to an

Arch-based distro with a kernel new enough to carry this patch that I

dropped to 60Hz, and it took a fair amount of EDID diffing to work out

why. So whatever QA issue prompted limiting this panel to 60Hz in the

BIOS EDID, it doesn't seem to have been hit by years of real-world use

at 90Hz on this unit under Linux, for whatever that's worth as a data

point.



Given that, I don't think this needs a behaviour change on your end,

just wanted it on record for anyone else who hits the same "why did my

refresh rate drop after a kernel/distro update" confusion and finds

the ticket. I'll add a note with this context to the GitLab issue.



Thanks again for the quick response.



Narek











From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: "Narek Sarkissian"<narek@sarx-technology.com>, "Mario Limonciello"<superm1@kernel.org>
Cc: "Alex Hung"<alex.hung@amd.com>, "Alexander Deucher"<alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, <kernel-dev@igalia.com>, "Limonciello,  Mario"<mario.limonciello@amd.com>, "Melissa Wen"<mwen@igalia.com>, <sunpeng.li@amd.com>
Date: Fri, 28 Aug 2026 20:19:14 +0100
Subject: Re: [PATCH v8 5/5] drm/amd/display: Fetch the EDID from _DDC if available for eDP



Hi Narek 
 
On Fri, Aug 28, 2026, at 3:07 PM, Narek Sarkissian wrote: 
> Hi Mario, Alex, Alexander, 
> 
> Following up on this patch (c6a837088bed) with a regression report on a 
> different Lenovo model. 
> 
> On a ThinkPad T14s Gen 3 (AMD Radeon 680M / Rembrandt, DCN 3.1.2), this 
> change causes the internal eDP panel to be capped at 60Hz even though 
> the panel natively supports 90Hz. dm_helpers_read_local_edid() finds 
> an ACPI-provided EDID via _DDC and uses it unconditionally, but on 
> this machine that ACPI blob is a stale/incomplete copy of the panel's 
> real EDID: it encodes only a 60Hz detailed timing, while a live DP AUX 
> read of the same panel (Samsung Display, ATNA40YK08-0) returns 90Hz as 
> the native/preferred timing plus 60Hz as a secondary mode. Both DTDs 
> share the same pixel clock and htotal, so the ACPI copy looks like it 
> was deliberately downclocked rather than being a different display. 
> 
> dmesg confirms the code path taken: 
> 
>   amdgpu 0000:33:00.0: [drm] Using ACPI provided EDID for eDP-1 
> 
> Booting with amdgpu.dcdebugmask=0x8000 (DC_DISABLE_ACPI_EDID) skips 
> the ACPI EDID and forces the live AUX read, which correctly exposes 
> 90Hz and reports the panel's real vendor (Samsung) instead of Lenovo's 
> ACPI-authored EDID (manufacturer/model LEN 16713). 
> 
> Full writeup with the EDID diff (byte-level comparison of the ACPI 
> blob vs. the live-read panel EDID), environment details, and repro 
> steps is here: 
> 
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5710  
> 
> Since this same unconditional ACPI-EDID preference apparently fixes 
> T14 Gen 4 but regresses T14s Gen 3, an unconditional preference in 
> either direction doesn't seem to work for all eDP panels globally. 
> Possible directions raised in the issue: fall back to ACPI only when 
> the live AUX read fails (inverting current priority), prefer whichever 
> source has more/higher-refresh timings, or gate the ACPI-EDID 
> preference behind a DMI-based quirk table scoped to the models that 
> actually need it. 
> 
I think this is working as designed. 
 
I'll try to find our internal ticket with the details (my memory is a bit rusty and this is a few years old now), but as I recall they saw issues with Windows testing with 90Hz and so limited the panel to 60Hz - using the BIOS EDID to do this. Linux is just following the 'manufacturer recommendation'. 
 
If you're not seeing issues, then overriding it to use the panel EDID is fine, but just be aware that the 90Hz did not pass Lenovo QA. 
 
Mark
------=_Part_4443178_633772278.1787945614928
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>=
<meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"></h=
ead><body ><div style=3D"font-family: Verdana, Arial, Helvetica, sans-serif=
; font-size: 10pt;"><div>Mark,<br></div><div><br></div><div>&gt; I think th=
is is working as designed.<br></div><div>&gt;<br></div><div>&gt; I'll try t=
o find our internal ticket with the details (my memory is a<br></div><div>&=
gt; bit rusty and this is a few years old now), but as I recall they saw<br=
></div><div>&gt; issues with Windows testing with 90Hz and so limited the p=
anel to<br></div><div>&gt; 60Hz - using the BIOS EDID to do this. Linux is =
just following the<br></div><div>&gt; 'manufacturer recommendation'.<br></d=
iv><div>&gt;<br></div><div>&gt; If you're not seeing issues, then overridin=
g it to use the panel<br></div><div>&gt; EDID is fine, but just be aware th=
at the 90Hz did not pass Lenovo QA.<br></div><div><br></div><div>Thanks for=
 the context, that's useful to know, and no, I'm not seeing<br></div><div>a=
ny issues running at 90Hz so far.<br></div><div><br></div><div>The reason I=
 wanted to flag it rather than just quietly carry the<br></div><div>overrid=
e locally: this same laptop ran 90Hz without any problems for<br></div><div=
>about four years across several Ubuntu-based distros (XFCE and KDE<br></di=
v><div>sessions) on older kernels. It was only after switching to an<br></d=
iv><div>Arch-based distro with a kernel new enough to carry this patch that=
 I<br></div><div>dropped to 60Hz, and it took a fair amount of EDID diffing=
 to work out<br></div><div>why. So whatever QA issue prompted limiting this=
 panel to 60Hz in the<br></div><div>BIOS EDID, it doesn't seem to have been=
 hit by years of real-world use<br></div><div>at 90Hz on this unit under Li=
nux, for whatever that's worth as a data<br></div><div>point.<br></div><div=
><br></div><div>Given that, I don't think this needs a behaviour change on =
your end,<br></div><div>just wanted it on record for anyone else who hits t=
he same "why did my<br></div><div>refresh rate drop after a kernel/distro u=
pdate" confusion and finds<br></div><div>the ticket. I'll add a note with t=
his context to the GitLab issue.<br></div><div><br></div><div>Thanks again =
for the quick response.<br></div><div><br></div><div>Narek<br></div><div><b=
r></div><div id=3D"Zm-_Id_-Sgn" data-sigid=3D"619332000000337007" data-zblu=
epencil-ignore=3D"true"><br></div><div><br></div><div class=3D"zmail_extra_=
hr" style=3D"border-top: 1px solid rgb(204, 204, 204); height: 0px; margin-=
top: 10px; margin-bottom: 10px; line-height: 0px;"><br></div><div class=3D"=
zmail_extra" data-zbluepencil-ignore=3D"true"><div><br></div><div id=3D"Zm-=
_Id_-Sgn1">From: Mark Pearson &lt;mpearson-lenovo@squebb.ca&gt;<br>To: "Nar=
ek Sarkissian"&lt;narek@sarx-technology.com&gt;, "Mario Limonciello"&lt;sup=
erm1@kernel.org&gt;<br>Cc: "Alex Hung"&lt;alex.hung@amd.com&gt;, "Alexander=
 Deucher"&lt;alexander.deucher@amd.com&gt;, &lt;amd-gfx@lists.freedesktop.o=
rg&gt;, &lt;dri-devel@lists.freedesktop.org&gt;, &lt;harry.wentland@amd.com=
&gt;, &lt;kernel-dev@igalia.com&gt;, "Limonciello,  Mario"&lt;mario.limonci=
ello@amd.com&gt;, "Melissa Wen"&lt;mwen@igalia.com&gt;, &lt;sunpeng.li@amd.=
com&gt;<br>Date: Fri, 28 Aug 2026 20:19:14 +0100<br>Subject: Re: [PATCH v8 =
5/5] drm/amd/display: Fetch the EDID from _DDC if available for eDP<br></di=
v><div><br></div><blockquote style=3D"margin: 0px;" id=3D"blockquote_zmail"=
><div>Hi Narek <br> <br>On Fri, Aug 28, 2026, at 3:07 PM, Narek Sarkissian =
wrote: <br>&gt; Hi Mario, Alex, Alexander, <br>&gt; <br>&gt; Following up o=
n this patch (c6a837088bed) with a regression report on a <br>&gt; differen=
t Lenovo model. <br>&gt; <br>&gt; On a ThinkPad T14s Gen 3 (AMD Radeon 680M=
 / Rembrandt, DCN 3.1.2), this <br>&gt; change causes the internal eDP pane=
l to be capped at 60Hz even though <br>&gt; the panel natively supports 90H=
z. dm_helpers_read_local_edid() finds <br>&gt; an ACPI-provided EDID via _D=
DC and uses it unconditionally, but on <br>&gt; this machine that ACPI blob=
 is a stale/incomplete copy of the panel's <br>&gt; real EDID: it encodes o=
nly a 60Hz detailed timing, while a live DP AUX <br>&gt; read of the same p=
anel (Samsung Display, ATNA40YK08-0) returns 90Hz as <br>&gt; the native/pr=
eferred timing plus 60Hz as a secondary mode. Both DTDs <br>&gt; share the =
same pixel clock and htotal, so the ACPI copy looks like it <br>&gt; was de=
liberately downclocked rather than being a different display. <br>&gt; <br>=
&gt; dmesg confirms the code path taken: <br>&gt; <br>&gt;   amdgpu 0000:33=
:00.0: [drm] Using ACPI provided EDID for eDP-1 <br>&gt; <br>&gt; Booting w=
ith amdgpu.dcdebugmask=3D0x8000 (DC_DISABLE_ACPI_EDID) skips <br>&gt; the A=
CPI EDID and forces the live AUX read, which correctly exposes <br>&gt; 90H=
z and reports the panel's real vendor (Samsung) instead of Lenovo's <br>&gt=
; ACPI-authored EDID (manufacturer/model LEN 16713). <br>&gt; <br>&gt; Full=
 writeup with the EDID diff (byte-level comparison of the ACPI <br>&gt; blo=
b vs. the live-read panel EDID), environment details, and repro <br>&gt; st=
eps is here: <br>&gt; <br>&gt; <a href=3D"https://gitlab.freedesktop.org/dr=
m/amd/-/work_items/5710" target=3D"_blank">https://gitlab.freedesktop.org/d=
rm/amd/-/work_items/5710</a> <br>&gt; <br>&gt; Since this same unconditiona=
l ACPI-EDID preference apparently fixes <br>&gt; T14 Gen 4 but regresses T1=
4s Gen 3, an unconditional preference in <br>&gt; either direction doesn't =
seem to work for all eDP panels globally. <br>&gt; Possible directions rais=
ed in the issue: fall back to ACPI only when <br>&gt; the live AUX read fai=
ls (inverting current priority), prefer whichever <br>&gt; source has more/=
higher-refresh timings, or gate the ACPI-EDID <br>&gt; preference behind a =
DMI-based quirk table scoped to the models that <br>&gt; actually need it. =
<br>&gt; <br>I think this is working as designed. <br> <br>I'll try to find=
 our internal ticket with the details (my memory is a bit rusty and this is=
 a few years old now), but as I recall they saw issues with Windows testing=
 with 90Hz and so limited the panel to 60Hz - using the BIOS EDID to do thi=
s. Linux is just following the 'manufacturer recommendation'. <br> <br>If y=
ou're not seeing issues, then overriding it to use the panel EDID is fine, =
but just be aware that the 90Hz did not pass Lenovo QA. <br> <br>Mark <br><=
/div></blockquote></div><div><br></div></div><br></body></html>
------=_Part_4443178_633772278.1787945614928--



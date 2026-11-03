Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265C606A328
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShNGHf4F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AFB10F6AB;
	Tue,  3 Nov 2026 15:54:19 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3769310F6AC
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:54:13 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-7be536cd40dso200624137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 07:54:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793721252; cv=none;
 d=google.com; s=arc-20260327;
 b=WK5got22uC8Lq45+amzqzc0vJe80h1Dn4GxjwOwLd9DxAu9z5GW4YDEk284GkuRX0v
 CLCU0t2gjEoU5oxAVNX2fm2WpK/XRulcgbygJZOZomPC/OY3ch1EOkVUCltUEEIS7o3H
 KPTOSIKlYGFmkG9lhI9GWp3wiPGSk8OVNlblkW3hSgqExEgo6kVxO0RGJjJzNIYfOPAZ
 5SXqqFrgziMTX02NPdxYcsvdLdoSP4og71o2CTTGRRFgiMLcbdPUr+ZUIdENSKBgih3v
 rtFVw6Q886rmJL7XJ9gbWC3NZgQrGeQy/Ge5MnoxTv03OF/F3PqLFDyIjszsIgaQLBRa
 Oj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xb8msZ+fgXjMEHN+Y/BoflVk8iRjVl0Wk5Yh+DJWfoM=;
 fh=kCIufOIazEKLFbjaFOLNk4fWSW7MoUWjjxNUktSEyaI=;
 b=hhBeVqwa/DHEWrxmsX3vKGjM22kkDIewE9o4Mzbfo1cNg7Zq2qH2UaLNe2MhZKv+NE
 Qm1An0JK0F3V47RTPJxig22zk2MSqwUxKbm7urUa0WpKIZ1fU8zrawCUNGnguX9tkrxT
 yR+JuWJ1HTY/f07gQYfGRdiveRZQxq29oz2XSolvV7uREs6GHKbKst9Jf7BgO3mHmtgK
 p1HN6JjfsUydm2caOVWuL+Kme5DoVB3bir01zYfmhGJpDvKQfFfrVzuWA9TzXnxbEmOD
 Lt+Ax2lXPb5sA+G2OI/oj37JYUCgCXElCCKKmjYEtSByIlb9W7fda9mHivX92k62Ik8m
 p/oQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793721252; x=1794326052; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xb8msZ+fgXjMEHN+Y/BoflVk8iRjVl0Wk5Yh+DJWfoM=;
 b=ShNGHf4FwOaVWccUlqVifIk7hFxUSwqXwJtRf6H9Rfz5DFwC5tq7RQ5OHYse1yZgdE
 OM7sfKlRN+8gFZIAIfRSnA4mfBZtOuy632HQ6aKB3r6a0R4iDGMAZ7oTxnVsaJ7tkS4r
 f3JTx1olw1hrN1Z7q8A7JhxhdqRW/GuouLvUI+qkm16b7GV8l5htUvO3P9XC9M/jyu6P
 xo5/Fzc+HmNN2ZpU+17HpZXdd66o9PjkfnF3VIWz/A2kTdLh+ipspNU+ewdsFvoZeT4x
 xx5zRfL09RUXTMVF2hRpX+fNiUg+TCApNqttsn+Urp0UoACc+1C2TUtcMljAS7+gpb8D
 tZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721252; x=1794326052;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xb8msZ+fgXjMEHN+Y/BoflVk8iRjVl0Wk5Yh+DJWfoM=;
 b=HAf3c37h38/uFYGhphR27fnShU9/VbVOhMi0OlLDrPR041zd4XXqWwBCZ7tZ1XWgWC
 mynQs9pQsX5dgTJiVjP1BeoZHyaQ59BUW0ypdPxue0/Sjws0fiIhmTeJjFoL3U87mHtd
 cuZCj/WmK/fJt2/wTtyRBVRq3cg4jyhWFpyTslRn7al9htr6Trs0uCnGr0PX/m8ZWHmY
 vlu4n8TJh+tfS1jXV6/XpZQfDZjY9LNT0gb5BkIE0z3vnVI6PdmbTUQTEITLYNOSDe5O
 x6VkAgvDS+WHZE637q5Ck37yh0yH2EjrUN6kj8NYq2JkJPWMRRghfGvtdPXDkr6+rVt+
 GJ/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2sOGdZY03t5V/RWGUIduFavNNa8d+oe1L5NVc8LqiODnfFStM29L3djZPvBHZN4xvOvymYJiSm7Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/caohFCHguNwgzK0x0pca38aeIbd0cm1OY52w73N3pXLykuVq6
 s435vkvonFcb/2gNCBO8r88ZR13VQrVLAg4rQvOBx/WmZQ0oS0wY/IiDmmMEVcibEaIJt8o+AQ3
 kXSgQQmNBBKnQtKEIez0obw86CylnnKE=
X-Gm-Gg: AYBFou0DEJFB6EVK8vtkDxysqUnG0oFqso6WZNG+FHo1LT1MpM3lY+EvtxSXGmfKLnX
 vmPSKLCdp667hcgX+wMLlScAaz7av2Pj7RZ/JtS2gRCEqpzVbrbByULuD22xR0xjPJ0WjAizigt
 VdaFeVC2Ms8YuL+WLDS9Ez68bTJI7eaUXzPUSjD/qgIMed3P+lTLE8m+zFdVAoS3hEumxRvcvQh
 GA1o0xTtyD21dh6/dRp0JfCPF5nORdEkJP3ddR71gg5ob8DN+GCZ7ty0x6w2Q//1UwTfp135rZy
 GmfzKDVZxS2RHS39bl7PGziSGfeb9lVKUu2spwkyAQZkWhA6T5yaG3Gm4Iyo4V4XLSHFLpoDyXj
 muGWd6ZyYDI8d3nn94pSrNhRNMyZIkq+/S4uaKxGDWOK/vXOTpE05meOyJBo5ebHE9QGrbzeud/
 VMqd3PPXfqV7sk9PNY9vIyyLc=
X-Received: by 2002:a05:6102:6484:20b0:7ca:21e4:8e20 with SMTP id
 ada2fe7eead31-7d072ba07b2mr5499484137.2.1793721252076; Tue, 03 Nov 2026
 07:54:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260916144014.879355-1-ed@aicharmers.com>
 <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
 <20261030123000.5573e70f@kait2en-mbp15-1>
 <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103162512.2ec834ac@kait2en-mbp15-1>
In-Reply-To: <20261103162512.2ec834ac@kait2en-mbp15-1>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 10:53:56 -0500
X-Gm-Features: AclHuK8XgaXraLodmmVFuSHrr-OuzfGpqPbHuNNCdg5f56R66moLICOm5O2si5g
Message-ID: <CADnq5_NDJ7V=TQLOJ37msbmhwsVG+70mPKU3ns+xmAu9jxWwcg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: =?UTF-8?Q?Andr=C3=A9_Eikmeyer?= <dev@deq.rocks>
Cc: Ed Schofield <ed@aicharmers.com>, amd-gfx@lists.freedesktop.org, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000e8f73065f614643"
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000000e8f73065f614643
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:25=E2=80=AFAM Andr=C3=A9 Eikmeyer <dev@deq.rocks>=
 wrote:
>
> On Tue, 3 Nov 2026 09:30:34 -0500
> Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > It is the same issue.  I don't want two fixes for the same issue.
>
> Understandable, but it is not. Two devs told you the same
> independently.
> On another note I reviewed your patch. It only rejects empty or zero
> levels. On the 16,1 the pptable levels (736/750 MHz) are non-zero.
> Besides other issues in the code, the commit message says the exact
> patch wasn't tested, yet v5 extends it to every Apple Navi 1x.
> I am sorry but your patch is implausible to me.

I forgot to remove the pptable check.  Can you try a simplified
version of the patch?  I think all you need to do is delay the UCLK
DPM enablement until late_init.  Something like the attached patch.

Alex

--0000000000000e8f73065f614643
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amd-pm-defer-UCLK-DPM-on-selected-Apple-Navi-GPU.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-pm-defer-UCLK-DPM-on-selected-Apple-Navi-GPU.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mw0vas0f0>
X-Attachment-Id: f_mw0vas0f0

RnJvbSAwY2Y4YzUwMTA4NzVhMmNmMjU3NGJlMmJmYjY5MGZkODVhMGRhNzQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBdGhhcnZhIFRpd2FyaSA8YXRoYXJ2YXRpd2FyaWxpbnV4ZGV2
QGdtYWlsLmNvbT4KRGF0ZTogV2VkLCAxNiBTZXAgMjAyNiAxNDo0MDoxNCArMDAwMApTdWJqZWN0
OiBbUEFUQ0hdIGRybS9hbWQvcG06IGRlZmVyIFVDTEsgRFBNIG9uIHNlbGVjdGVkIEFwcGxlIE5h
dmkgR1BVcwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKQXBwbGUgTmF2aSBHUFVz
IGludGVybWl0dGVudGx5IHRpbWUgb3V0IGR1cmluZyBTTVUgaW5pdGlhbGl6YXRpb24Kd2hlbiBF
bmFibGVBbGxTbXVGZWF0dXJlcyBpbmNsdWRlcyBVQ0xLIERQTS4gTGVhdmUgVUNMSyBvdXQgb2Yg
dGhhdCBlYXJseQpyZXF1ZXN0IGFuZCBlbmFibGUgaXQgZnJvbSBOYXZpIHBvc3QtaW5pdCwgYWZ0
ZXIgZGlzcGxheSBoYXJkd2FyZSBpbml0CmFuZCBiZWZvcmUgdGhlIFVNQyB3b3JrYXJvdW5kIGFu
ZCBVTUQgY2xvY2sgc2V0dXAuCgpSZWFkIGJhY2sgdGhlIGVuYWJsZWQgZmVhdHVyZXMgYmVmb3Jl
IHJlYnVpbGRpbmcgdGhlIG1lbW9yeSBjbG9jayB0YWJsZQphbmQgc3VzdGFpbmFibGUgY2xvY2sg
bGltaXRzLiBBbHNvIGNoZWNrIHRoZSBQUFQgbWVtb3J5IHN0YXRlcyB1c2VkIGJ5CmRpc3BsYXkg
aW5pdGlhbGl6YXRpb24gYmVmb3JlIGxhdGUgZW5hYmxlbWVudC4gS2VlcCBtZW1vcnktdm9sdGFn
ZSBEUE0KYW5kIHJlc3BlY3QgdGhlIHVzZXIncyBtZW1vcnktRFBNIHNldHRpbmcgYW5kIHRoZSBz
ZWN1cmUgTmF2aSAxMCBleGNsdXNpb24uCgpUaGlzIGJ1aWxkcyBvbiBBdGhhcnZhIFRpd2FyaSdz
IHN1Ym1pdHRlZCAwMjE5IGRlbGF5ZWQtVUNMSyBwYXRjaAphbmQgR3VuYSdzIGRpYWdub3Npcy4g
RWQgU2Nob2ZpZWxkIG1vdmVkIHRoZSBlbmFibGUgcG9pbnQgaW50byB0aGUKTmF2aSBjYWxsYmFj
aywgYWRkZWQgc3RhdGUgdmFsaWRhdGlvbi4KSW5kZXBlbmRlbnQgdGVzdHMgb2YgdGhlIHJlbGF0
ZWQgVDIgaW1wbGVtZW50YXRpb24gc3VwcG9ydCBpbXByb3ZlZCBib290CnJlbGlhYmlsaXR5IG9u
IDAyMTkgYW5kIDAyMWE7IHRob3NlIGFyZSBub3QgdGVzdHMgb2YgdGhpcyBleGFjdCBBTUQgcGF0
Y2guCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbWQtZ2Z4LzIwMjYwODI0MTkwNDA5
LjE3MjQtMS1hdGhhcnZhdGl3YXJpbGludXhkZXZAZ21haWwuY29tLwpMaW5rOiBodHRwczovL2dp
dGh1Yi5jb20vdDJsaW51eC9saW51eC10Mi1wYXRjaGVzL3B1bGwvNjEjaXNzdWVjb21tZW50LTU2
Mzc5NzY0NjYKTGluazogaHR0cHM6Ly9naXRodWIuY29tL3QybGludXgvbGludXgtdDItcGF0Y2hl
cy9wdWxsLzYxI2lzc3VlY29tbWVudC01NjQ1NjUyNzUyCkNsb3NlczogaHR0cHM6Ly9naXRsYWIu
ZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS93b3JrX2l0ZW1zLzYwMDUKQXNzaXN0ZWQtYnk6IENv
ZGV4OkdQVC02CkNjOiBBbmRyw6kgRWlrbWV5ZXIgPGRldkBkZXEucm9ja3M+ClNpZ25lZC1vZmYt
Ynk6IEF0aGFydmEgVGl3YXJpIDxhdGhhcnZhdGl3YXJpbGludXhkZXZAZ21haWwuY29tPgpDby1k
ZXZlbG9wZWQtYnk6IEVkIFNjaG9maWVsZCA8ZWRAYWljaGFybWVycy5jb20+ClNpZ25lZC1vZmYt
Ynk6IEVkIFNjaG9maWVsZCA8ZWRAYWljaGFybWVycy5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiAuLi4vZ3B1L2RybS9hbWQv
cG0vc3dzbXUvc211MTEvbmF2aTEwX3BwdC5jICAgfCA1NCArKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTEvbmF2aTEwX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMS9uYXZpMTBfcHB0LmMKaW5kZXggMmQwNTA4ODYxOWY2ZC4uNjcyZDc0
MGU3Mjg4MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9u
YXZpMTBfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9uYXZp
MTBfcHB0LmMKQEAgLTYwLDYgKzYwLDI1IEBACiAKIHN0YXRpYyBpbnQgbmF2aTEwX2luaXRfcHB0
X2xpbWl0cyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7CiAKK3N0YXRpYyBib29sIGlzX2FzaWNf
c2VjdXJlKHN0cnVjdCBzbXVfY29udGV4dCAqc211KTsKKworc3RhdGljIGJvb2wgbmF2aTEwX2Fw
cGxlX25lZWRzX2xhdGVfdWNsayhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKK3sKKwlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRldjsKKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9
IGFkZXYtPnBkZXY7CisKKwlpZiAoIShhZGV2LT5wbS5wcF9mZWF0dXJlICYgUFBfTUNMS19EUE1f
TUFTSykpCisJCXJldHVybiBmYWxzZTsKKworCS8qIFByZXNlcnZlIHRoZSBleGlzdGluZyBzZWN1
cmUgTmF2aSAxMCBtZW1vcnktRFBNIGV4Y2x1c2lvbi4gKi8KKwlpZiAoaXNfYXNpY19zZWN1cmUo
c211KSAmJgorCSAgICBhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBNUDFfSFdJUCwgMCkgPT0gSVBf
VkVSU0lPTigxMSwgMCwgMCkgJiYKKwkgICAgYWRldi0+cmV2X2lkID09IDApCisJCXJldHVybiBm
YWxzZTsKKworCXJldHVybiBwZGV2LT5zdWJzeXN0ZW1fdmVuZG9yID09IFBDSV9WRU5ET1JfSURf
QVBQTEU7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc211X2ZlYXR1cmVfYml0cyBuYXZpMTBf
ZHBtX2ZlYXR1cmVzID0gewogCS5iaXRzID0gewogCQlTTVVfRkVBVFVSRV9CSVRfSU5JVChGRUFU
VVJFX0RQTV9QUkVGRVRDSEVSX0JJVCksCkBAIC0zNTYsNiArMzc1LDExIEBAIG5hdmkxMF9pbml0
X2FsbG93ZWRfZmVhdHVyZXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCiAJCXNtdV9mZWF0dXJl
X2xpc3Rfc2V0X2JpdChzbXUsIFNNVV9GRUFUVVJFX0xJU1RfQUxMT1dFRCwgRkVBVFVSRV9NRU1f
TVZERF9TQ0FMSU5HX0JJVCk7CiAJfQogCisJLyogRGVmZXIgVUNMSyBvbiB0aGUgc2VsZWN0ZWQg
QXBwbGUgYm9hcmRzIHVudGlsIElQIGxhdGUgaW5pdC4gKi8KKwlpZiAobmF2aTEwX2FwcGxlX25l
ZWRzX2xhdGVfdWNsayhzbXUpKQorCQlzbXVfZmVhdHVyZV9saXN0X2NsZWFyX2JpdChzbXUsIFNN
VV9GRUFUVVJFX0xJU1RfQUxMT1dFRCwKKwkJCQkJICAgRkVBVFVSRV9EUE1fVUNMS19CSVQpOwor
CiAJaWYgKGlzX2FzaWNfc2VjdXJlKHNtdSkgJiYKIAkgICAgKGFtZGdwdV9pcF92ZXJzaW9uKGFk
ZXYsIE1QMV9IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDExLCAwLCAwKSkgJiYKIAkgICAgKGFkZXYt
PnJldl9pZCA9PSAwKSkKQEAgLTMyMTksNiArMzI0MywzMCBAQCBzdGF0aWMgaW50IG5hdmkxMF9l
bmFibGVfbWdwdV9mYW5fYm9vc3Qoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCiAJCQkJCSAgICAg
ICBOVUxMKTsKIH0KIAorLyogSVAgbGF0ZSBpbml0IGZvbGxvd3MgZGlzcGxheSBod19pbml0OyBy
ZWZyZXNoIGNsb2NrcyBiZWZvcmUgVU1DL1VNRCBzZXR1cC4gKi8KK3N0YXRpYyBpbnQgbmF2aTEw
X2FwcGxlX2xhdGVfdWNsa19lbmFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCit7CisJc3Ry
dWN0IHNtdV9mZWF0dXJlX2JpdHMgZW5hYmxlZDsKKwlpbnQgcmV0OworCisJaWYgKCFuYXZpMTBf
YXBwbGVfbmVlZHNfbGF0ZV91Y2xrKHNtdSkpCisJCXJldHVybiAwOworCisJcmV0ID0gc211X2Nt
bl9mZWF0dXJlX3NldF9lbmFibGVkKHNtdSwgU01VX0ZFQVRVUkVfRFBNX1VDTEtfQklULCB0cnVl
KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCXJldCA9IHNtdV9jbW5fZ2V0X2VuYWJsZWRf
bWFzayhzbXUsICZlbmFibGVkKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCWlmICghc211
X2ZlYXR1cmVfYml0c19pc19zZXQoJmVuYWJsZWQsIEZFQVRVUkVfRFBNX1VDTEtfQklUKSkKKwkJ
cmV0dXJuIC1FSU87CisKKwlzbXVfZmVhdHVyZV9saXN0X3NldF9iaXQoc211LCBTTVVfRkVBVFVS
RV9MSVNUX1NVUFBPUlRFRCwKKwkJCQkgRkVBVFVSRV9EUE1fVUNMS19CSVQpOworCisJcmV0dXJu
IDA7Cit9CisKIHN0YXRpYyBpbnQgbmF2aTEwX3Bvc3Rfc211X2luaXQoc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7CkBA
IC0zMjI3LDYgKzMyNzUsMTIgQEAgc3RhdGljIGludCBuYXZpMTBfcG9zdF9zbXVfaW5pdChzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSkKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQogCQlyZXR1
cm4gMDsKIAorCXJldCA9IG5hdmkxMF9hcHBsZV9sYXRlX3VjbGtfZW5hYmxlKHNtdSk7CisJaWYg
KHJldCkgeworCQlkZXZfZXJyKGFkZXYtPmRldiwgIkZhaWxlZCB0byBlbmFibGUgbGF0ZSBVQ0xL
IERQTTogJWRcbiIsIHJldCk7CisJCXJldHVybiByZXQ7CisJfQorCiAJcmV0ID0gbmF2aTEwX3J1
bl91bWNfY2RyX3dvcmthcm91bmQoc211KTsKIAlpZiAocmV0KQogCQlkZXZfZXJyKGFkZXYtPmRl
diwgIkZhaWxlZCB0byBhcHBseSB1bWMgY2RyIHdvcmthcm91bmQhXG4iKTsKLS0gCjIuNTYuMAoK
--0000000000000e8f73065f614643--

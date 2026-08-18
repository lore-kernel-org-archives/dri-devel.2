Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA3C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D986110EA5E;
	Wed, 19 Aug 2026 06:36:35 +0000 (UTC)
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3894710E9CF
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:48:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08706097|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.244905-0.00531846-0.749776;
 FP=3403197374508759771|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033032023038;
 MF=support@armdesigner.com; NM=1; PH=DS; RN=1; RT=1; SR=0;
 TI=SMTPD_---.ipms61x_1787024910; 
Received: from DESKTOP-F4DGRM2(mailfrom:support@armdesigner.com
 fp:SMTPD_---.ipms61x_1787024910 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 18 Aug 2026 11:48:31 +0800
Date: Tue, 18 Aug 2026 11:48:30 +0800
Organization: boardcon
From: support <support@armdesigner.com>
To: dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.563[cn]
Mime-Version: 1.0
Message-ID: <202608181148299703855@armdesigner.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart642481822616_=----"
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

This is a multi-part message in MIME format.

------=_001_NextPart642481822616_=----
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

SGkgSWdvciwNClRoYW5rcyBmb3IgdGhlIHRob3JvdWdoIGV4cGVyaW1lbnRhbCB3b3JrIGFuZCB0
aGUgdjIgcmV3b3JrLiBUaGUgcGVyLXBvcnQNCnBpeGVsIHJhdGUgYW5hbHlzaXMgaXMgd2VsbC1y
ZWFzb25lZCAtLSB0aGUgWUNiQ3IgNDoyOjAgZGlzdGluY3Rpb24gKGRjbGsNCmhhbHZlZCwgcGl4
ZWwgY29uc3VtcHRpb24gcmF0ZSB1bmNoYW5nZWQpIGlzIGEgc3VidGxlIHBvaW50IHRoYXQncyBl
YXN5IHRvDQptaXNzLCBhbmQgdGhlIHRocmVlLXBvcnQgdnMuIG9uZS1wb3J0IGNvbXBhcmlzb24g
dGhhdCBwaW5zIHRoZSBjb25kaXRpb24NCm9uIHBlci1wb3J0IHBpeGVsIHJhdGUgcmF0aGVyIHRo
YW4gYWdncmVnYXRlIGJhbmR3aWR0aCBpcyBjbGVhbi4NCldlIHdvcmsgd2l0aCBSSzM1ODggaW4g
bXVsdGktZGlzcGxheSBpbmR1c3RyaWFsIGNvbmZpZ3VyYXRpb25zIChkaWdpdGFsDQpzaWduYWdl
LCBlZGdlIEFJIGRldmljZXMpIGFuZCBoYXZlIGluZGVwZW5kZW50bHkgaGl0IHRoZSBQT1NUX0JV
Rl9FTVBUWQ0KY29ycnVwdGlvbiBhdCA1MDAgTUh6IEFYSSBvbiBoaWdoLXBpeGVsLXJhdGUgbW9k
ZXMuIEFzIEhlaWtvIG5vdGVkIGJhY2sNCmluIHRoZSBpbml0aWFsIFZPUDIgdXBzdHJlYW1pbmcg
WzFdLCB0aGlzIGhhcyBiZWVuIGEgbG9uZy1zdGFuZGluZw0KbnVpc2FuY2UgLS0gZ29vZCB0byBz
ZWUgYSBwcm9wZXIgZml4IGluIHByb2dyZXNzLg0KQSBmZXcgb2JzZXJ2YXRpb25zOg0KVGhyZXNo
b2xkIGdhcCBhbmQgbWVtb3J5IGNvbnRlbnRpb24NCllvdSBub3RlZCBpbiB0aGUgaW5pdGlhbCBk
aXNjdXNzaW9uIFsyXSB0aGF0IHlvdXIgbW9uaXRvciBvZmZlcnMgbm90aGluZw0KYmV0d2VlbiAy
NTYweDE0NDBAMTQ0ICh+NTg2IE1IeikgYW5kIDM4NDB4MjE2MEAxMjAgKDExODggTUh6KSwgc28g
dGhlDQp0aHJlc2hvbGQgY291bGRuJ3QgYmUgYmlzZWN0ZWQuIFZPUDJfSElHSF9CV19QSVhDTEtf
S0haIGlzIHNldCB0byAxMDAwMDAwDQooMSBHSHopLCB3aGljaCBzaXRzIGluIHRoYXQgdW50ZXN0
ZWQgZ2FwLg0KSW4gZWRnZSBBSSBwcm9kdWN0cyB3aGVyZSB0aGUgTlBVICg2IFRPUFMpIGFuZCBW
UFUgYXJlIGFjdGl2ZSBhbG9uZ3NpZGUNCnRoZSBkaXNwbGF5IHBpcGVsaW5lLCB0aGUgVk9QMiBz
aGFyZXMgbWVtb3J5IGJhbmR3aWR0aCB3aXRoIG90aGVyIEFYSQ0KbWFzdGVycy4gVW5kZXIgY29t
YmluZWQgZGlzcGxheSArIE5QVSArIFZQVSBsb2FkLCB0aGUgZWZmZWN0aXZlIGZpbGwgcmF0ZQ0K
b2YgdGhlIHNjYW5vdXQgRklGTyBtYXkgZHJvcCBiZWxvdyB3aGF0IDUwMCBNSHogQVhJIHN1c3Rh
aW5zLCBldmVuIGF0DQpwaXhlbCByYXRlcyBiZWxvdyB0aGUgY3VycmVudCAxIEdIeiB0aHJlc2hv
bGQuIFRoZSBiaW5hcnkgNTAwLzc1MCBNSHoNCnN3aXRjaCBkb2Vzbid0IGFjY291bnQgZm9yIHRo
aXMuDQpUaGlzIGlzbid0IG5lY2Vzc2FyaWx5IGEgYmxvY2tlciBmb3IgdGhlIGluaXRpYWwgcGF0
Y2ggLS0gdGhlIGNvbW1vbiBjYXNlDQooZGlzcGxheS1vbmx5LCA0S0A2MCBvciBiZWxvdykgaXMg
YWxyZWFkeSBoYW5kbGVkIGNvcnJlY3RseS4gQnV0IGl0IG1heQ0KYmUgd29ydGggbm90aW5nIGFz
IGEga25vd24gbGltaXRhdGlvbiwgb3IgY29uc2lkZXJpbmcgYSBkZXZpY2UtdHJlZQ0KcHJvcGVy
dHkgdGhhdCBsZXRzIGJvYXJkcyB3aXRoIGhlYXZ5IG5vbi1kaXNwbGF5IEFYSSB0cmFmZmljIGxv
d2VyIHRoZQ0KdHJpZ2dlciBwb2ludC4NCk11bHRpLUNSVEMgZGlzYWJsZSByYWNlDQpXZSBjYW4g
Y29ycm9ib3JhdGUgdGhlIHNlY29uZCBTYXNoaWtvIGZpbmRpbmcgZnJvbSBwcm9kdWN0aW9uOiB3
aGVuIGENCm11bHRpLXNjcmVlbiBhZHZlcnRpc2luZyBkaXNwbGF5IHJlY29uZmlndXJlcyB0byBz
aW5nbGUtc2NyZWVuLCB0aGUNCndpbmRvdyB3aGVyZSB0aGUgQVhJIGNsb2NrIGRyb3BzIHdoaWxl
IG90aGVyIENSVENzIGFyZSBzdGlsbCBzY2FubmluZw0Kb3V0IGNhdXNlcyBicmllZiB0ZWFyaW5n
IG9uIHRoZSByZW1haW5pbmcgc2NyZWVuLiBUaGUgdmM0DQphdG9taWNfY29tbWl0X3NldHVwIC8g
Y29tbWl0X3RhaWwgYXBwcm9hY2ggeW91IGRlc2NyaWJlZCAtLSBob2xkaW5nDQptYXgob2xkLCBu
ZXcpIHVudGlsIGRybV9hdG9taWNfaGVscGVyX3dhaXRfZm9yX2ZsaXBfZG9uZSgpIC0tIGNsb3Nl
cw0KZXhhY3RseSB0aGlzIHdpbmRvdy4gRW5kb3JzZWQuDQpMb29raW5nIGF0IHRoZSB2YzQgaW1w
bGVtZW50YXRpb24sIHRoZSBrZXkgcGllY2UgaXMgdGhhdCBjb21taXRfc2V0dXANCnJlY29yZHMg
YSBwZW5kaW5nX2NvbW1pdCBwZXIgY2hhbm5lbCBhbmQgc3Vic2VxdWVudCBjb21taXRzIHdhaXQg
b24gaXQNCndpdGggZHJtX2NydGNfY29tbWl0X3dhaXQoKSBbM10sIHdoaWNoIGlzIHdoYXQgZW5m
b3JjZXMgb3JkZXJpbmcgYmV0d2Vlbg0Kbm9uLWJsb2NraW5nIGNvbW1pdHMgdGhhdCBzaGFyZSBv
bmx5IHRoZSBwcml2YXRlIG9iamVjdC4gV2l0aG91dCB0aGF0LA0KdjIncyBwcml2YXRlIHN0YXRl
IGlzIHNhZmUgd2l0aGluIGEgc2luZ2xlIGNvbW1pdCBidXQgY2FuIHN0aWxsIGJlDQpvdmVyd3Jp
dHRlbiBieSBhIHN0YWxlIHNuYXBzaG90IGZyb20gYW4gZWFybGllciBub24tYmxvY2tpbmcgY29t
bWl0IC0tDQpleGFjdGx5IGFzIFNhc2hpa28gZGVzY3JpYmVkLg0KVGhlcm1hbCBub3RlIGZvciBm
YW5sZXNzIGRlc2lnbnMNCk9uIGZhbmxlc3MgUkszNTg4SiBpbmR1c3RyaWFsIGVuY2xvc3VyZXMg
KGFtYmllbnQgNjBDKSwgc3VzdGFpbmVkDQo3NTAgTUh6IEFYSSByYWlzZXMgU29DIGp1bmN0aW9u
IHRlbXBlcmF0dXJlIGJ5IHJvdWdobHkgMy01QyBpbiBvdXINCm1lYXN1cmVtZW50cy4gVGhpcyBp
cyB3aXRoaW4gYnVkZ2V0IGZvciBvdXIgcHJvZHVjdHMsIGJ1dCB0aGUgYXV0b21hdGljDQpmYWxs
YmFjayB0byA1MDAgTUh6IHdoZW4gbm8gaGlnaC1iYW5kd2lkdGggcG9ydCBpcyBhY3RpdmUgLS0g
d2hpY2ggdGhlDQpwYXRjaCBhbHJlYWR5IGltcGxlbWVudHMgLS0gaXMgZXNzZW50aWFsIGZvciBm
YW5sZXNzIGRlc2lnbnMuIFBsZWFzZQ0KcmV0YWluIHRoYXQgYmVoYXZpb3IgaW4gdjMuDQpFcnJv
ciBwYXRoIGFuZCBGUkwgb3ZlcmxhcA0KQWdyZWVkIG9uIHRoZSBNZWRpdW0gZmluZGluZzogcm9j
a2NoaXBfcmdiX2ZpbmkoKSBiZWxvbmdzIGJlZm9yZSB0aGUNCmVycl9jcnRjcyBqdW1wLg0KT24g
dGhlIEhETUkgRlJMIG92ZXJsYXAgeW91IG5vdGVkIGluIHRoZSB2MSBjb3ZlciBsZXR0ZXIgLS0g
aXQgd291bGQNCmhlbHAgdG8gc3RhdGUgZXhwbGljaXRseSBpbiB2MyB3aGV0aGVyIHRoaXMgcGF0
Y2ggc3Vic3VtZXMgdGhlDQpGUkwtc3BlY2lmaWMgQUNMSyB3b3JrYXJvdW5kICg3ZTU4MGQxY2Mz
YWEgb24gdGhlIHJvY2tjaGlwLTM1ODggYnJhbmNoKQ0Kb3IgY29leGlzdHMgd2l0aCBpdC4gSGF2
aW5nIHR3byBpbmRlcGVuZGVudCBBQ0xLIHNjYWxpbmcgbWVjaGFuaXNtcw0KY291bGQgY29uZmxp
Y3QgaWYgYm90aCBhcmUgYWN0aXZlLg0KdjMgYXBwcm9hY2gNClBsYWNpbmcgY29tbWl0X3NldHVw
L2NvbW1pdF90YWlsIGluIHJvY2tjaGlwX21vZGVfY29uZmlnX2hlbHBlcnMNCihzaGFyZWQgYnkg
Vk9QIGFuZCBWT1AyKSB3aXRoIFJLMzU4OC1vbmx5IGJlaGF2aW9yIGlzIGFjY2VwdGFibGUgZnJv
bQ0Kb3VyIHBlcnNwZWN0aXZlLiBUaGUgc2hhcmVkIGhlbHBlcnMgYWxyZWFkeSBjYXJyeQ0KZHJt
X2F0b21pY19oZWxwZXJfY29tbWl0X3RhaWxfcnBtLCBzbyBhIHRoaW4gUkszNTg4IHdyYXBwZXIg
aXMgdGhlDQpsZXNzZXIgZXZpbCBjb21wYXJlZCB0byBkdXBsaWNhdGluZyB0aGUgY29tbWl0IHRh
aWwgaW4gdGhlIFZPUDIgZHJpdmVyLg0KTG9va2luZyBmb3J3YXJkIHRvIHYzLg0KWzFdIGh0dHBz
Oi8vbGttbC5pbmRpYW5hLmVkdS8yMzExLjEvMDYzMTIuaHRtbA0KWzJdIGh0dHBzOi8vd3d3Lm1h
aWwtYXJjaGl2ZS5jb20vZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZy9tc2c2MjY3NzUu
aHRtbA0KWzNdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9kcmktZGV2ZWwv
cGF0Y2gvMjAyMTA3MDcwODQ3NDUuMTM2NTM5MC0xMS1tYXhpbWVAY2Vybm8udGVjaC8NCkJlc3Qg
cmVnYXJkcywNCkJvYXJkY29uIEVtYmVkZGVkIERlc2lnbg0KaHR0cHM6Ly93d3cuYm9hcmRjb24u
Y29tDQo=

------=_001_NextPart642481822616_=----
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3Dus-ascii"><style>body { line-height: 1.5; }p { margin-top: 0px; margin=
-bottom: 0px; }.fox_html_content_dummy_textarea { position: absolute; over=
flow: hidden; width: 1px; height: 1px; opacity: 0; }body { font-size: 14px=
; font-family: Arial; color: rgb(0, 0, 0); line-height: 1.5; }</style></he=
ad><body>=0A<div><span></span><p style=3D"box-sizing: border-box; margin-r=
ight: 0px; margin-left: 0px; padding-bottom: 12px; font-family: -apple-sys=
tem, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif; font-size: 13px;">Hi Igor,</p><p style=3D"box-sizing:=
 border-box; margin-right: 0px; margin-left: 0px; padding-bottom: 12px; fo=
nt-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto=
, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;">Thanks for the=
 thorough experimental work and the v2 rework. The per-port<br style=3D"bo=
x-sizing: border-box;">pixel rate analysis is well-reasoned -- the YCbCr 4=
:2:0 distinction (dclk<br style=3D"box-sizing: border-box;">halved, pixel =
consumption rate unchanged) is a subtle point that's easy to<br style=3D"b=
ox-sizing: border-box;">miss, and the three-port vs. one-port comparison t=
hat pins the condition<br style=3D"box-sizing: border-box;">on per-port pi=
xel rate rather than aggregate bandwidth is clean.</p><p style=3D"box-sizi=
ng: border-box; margin-right: 0px; margin-left: 0px; padding-bottom: 12px;=
 font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;">We work wit=
h RK3588 in multi-display industrial configurations (digital<br style=3D"b=
ox-sizing: border-box;">signage, edge AI devices) and have independently h=
it the POST_BUF_EMPTY<br style=3D"box-sizing: border-box;">corruption at 5=
00 MHz AXI on high-pixel-rate modes. As Heiko noted back<br style=3D"box-s=
izing: border-box;">in the initial VOP2 upstreaming [1], this has been a l=
ong-standing<br style=3D"box-sizing: border-box;">nuisance -- good to see =
a proper fix in progress.</p><p style=3D"box-sizing: border-box; margin-ri=
ght: 0px; margin-left: 0px; padding-bottom: 4px; font-family: -apple-syste=
m, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&=
quot;, sans-serif; font-size: 13px;">A few observations:</p><ol style=3D"b=
ox-sizing: border-box; margin: 0px; padding-bottom: 12px; padding-left: 26=
px; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;"><li styl=
e=3D"box-sizing: border-box; margin: 0px; padding-bottom: 4px;">Threshold =
gap and memory contention</li></ol><p style=3D"box-sizing: border-box; mar=
gin-right: 0px; margin-left: 0px; padding-bottom: 12px; font-family: -appl=
e-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 13px;">You noted in the initial discu=
ssion [2] that your monitor offers nothing<br style=3D"box-sizing: border-=
box;">between 2560x1440@144 (~586 MHz) and 3840x2160@120 (1188 MHz), so th=
e<br style=3D"box-sizing: border-box;">threshold couldn't be bisected. VOP=
2_HIGH_BW_PIXCLK_KHZ is set to 1000000<br style=3D"box-sizing: border-box;=
">(1 GHz), which sits in that untested gap.</p><p style=3D"box-sizing: bor=
der-box; margin-right: 0px; margin-left: 0px; padding-bottom: 12px; font-f=
amily: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &q=
uot;Helvetica Neue&quot;, sans-serif; font-size: 13px;">In edge AI product=
s where the NPU (6 TOPS) and VPU are active alongside<br style=3D"box-sizi=
ng: border-box;">the display pipeline, the VOP2 shares memory bandwidth wi=
th other AXI<br style=3D"box-sizing: border-box;">masters. Under combined =
display + NPU + VPU load, the effective fill rate<br style=3D"box-sizing: =
border-box;">of the scanout FIFO may drop below what 500 MHz AXI sustains,=
 even at<br style=3D"box-sizing: border-box;">pixel rates below the curren=
t 1 GHz threshold. The binary 500/750 MHz<br style=3D"box-sizing: border-b=
ox;">switch doesn't account for this.</p><p style=3D"box-sizing: border-bo=
x; margin-right: 0px; margin-left: 0px; padding-bottom: 4px; font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Hel=
vetica Neue&quot;, sans-serif; font-size: 13px;">This isn't necessarily a =
blocker for the initial patch -- the common case<br style=3D"box-sizing: b=
order-box;">(display-only, 4K@60 or below) is already handled correctly. B=
ut it may<br style=3D"box-sizing: border-box;">be worth noting as a known =
limitation, or considering a device-tree<br style=3D"box-sizing: border-bo=
x;">property that lets boards with heavy non-display AXI traffic lower the=
<br style=3D"box-sizing: border-box;">trigger point.</p><ol style=3D"box-s=
izing: border-box; margin: 0px; padding-bottom: 12px; padding-left: 26px; =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;"><li style=3D=
"box-sizing: border-box; margin: 0px; padding-bottom: 4px;">Multi-CRTC dis=
able race</li></ol><p style=3D"box-sizing: border-box; margin-right: 0px; =
margin-left: 0px; padding-bottom: 12px; font-family: -apple-system, BlinkM=
acSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sa=
ns-serif; font-size: 13px;">We can corroborate the second Sashiko finding =
from production: when a<br style=3D"box-sizing: border-box;">multi-screen =
advertising display reconfigures to single-screen, the<br style=3D"box-siz=
ing: border-box;">window where the AXI clock drops while other CRTCs are s=
till scanning<br style=3D"box-sizing: border-box;">out causes brief tearin=
g on the remaining screen. The vc4<br style=3D"box-sizing: border-box;">at=
omic_commit_setup / commit_tail approach you described -- holding<br style=
=3D"box-sizing: border-box;">max(old, new) until drm_atomic_helper_wait_fo=
r_flip_done() -- closes<br style=3D"box-sizing: border-box;">exactly this =
window. Endorsed.</p><p style=3D"box-sizing: border-box; margin-right: 0px=
; margin-left: 0px; padding-bottom: 4px; font-family: -apple-system, Blink=
MacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, s=
ans-serif; font-size: 13px;">Looking at the vc4 implementation, the key pi=
ece is that commit_setup<br style=3D"box-sizing: border-box;">records a pe=
nding_commit per channel and subsequent commits wait on it<br style=3D"box=
-sizing: border-box;">with drm_crtc_commit_wait() [3], which is what enfor=
ces ordering between<br style=3D"box-sizing: border-box;">non-blocking com=
mits that share only the private object. Without that,<br style=3D"box-siz=
ing: border-box;">v2's private state is safe within a single commit but ca=
n still be<br style=3D"box-sizing: border-box;">overwritten by a stale sna=
pshot from an earlier non-blocking commit --<br style=3D"box-sizing: borde=
r-box;">exactly as Sashiko described.</p><ol style=3D"box-sizing: border-b=
ox; margin: 0px; padding-bottom: 12px; padding-left: 26px; font-family: -a=
pple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helve=
tica Neue&quot;, sans-serif; font-size: 13px;"><li style=3D"box-sizing: bo=
rder-box; margin: 0px; padding-bottom: 4px;">Thermal note for fanless desi=
gns</li></ol><p style=3D"box-sizing: border-box; margin-right: 0px; margin=
-left: 0px; padding-bottom: 4px; font-family: -apple-system, BlinkMacSyste=
mFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-seri=
f; font-size: 13px;">On fanless RK3588J industrial enclosures (ambient 60C=
), sustained<br style=3D"box-sizing: border-box;">750 MHz AXI raises SoC j=
unction temperature by roughly 3-5C in our<br style=3D"box-sizing: border-=
box;">measurements. This is within budget for our products, but the automa=
tic<br style=3D"box-sizing: border-box;">fallback to 500 MHz when no high-=
bandwidth port is active -- which the<br style=3D"box-sizing: border-box;"=
>patch already implements -- is essential for fanless designs. Please<br s=
tyle=3D"box-sizing: border-box;">retain that behavior in v3.</p><ol style=
=3D"box-sizing: border-box; margin: 0px; padding-bottom: 12px; padding-lef=
t: 26px; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&qu=
ot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;"><li=
 style=3D"box-sizing: border-box; margin: 0px; padding-bottom: 4px;">Error=
 path and FRL overlap</li></ol><p style=3D"box-sizing: border-box; margin-=
right: 0px; margin-left: 0px; padding-bottom: 12px; font-family: -apple-sy=
stem, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 13px;">Agreed on the Medium finding: rock=
chip_rgb_fini() belongs before the<br style=3D"box-sizing: border-box;">er=
r_crtcs jump.</p><p style=3D"box-sizing: border-box; margin-right: 0px; ma=
rgin-left: 0px; padding-bottom: 4px; font-family: -apple-system, BlinkMacS=
ystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-=
serif; font-size: 13px;">On the HDMI FRL overlap you noted in the v1 cover=
 letter -- it would<br style=3D"box-sizing: border-box;">help to state exp=
licitly in v3 whether this patch subsumes the<br style=3D"box-sizing: bord=
er-box;">FRL-specific ACLK workaround (7e580d1cc3aa on the rockchip-3588 b=
ranch)<br style=3D"box-sizing: border-box;">or coexists with it. Having tw=
o independent ACLK scaling mechanisms<br style=3D"box-sizing: border-box;"=
>could conflict if both are active.</p><ol style=3D"box-sizing: border-box=
; margin: 0px; padding-bottom: 12px; padding-left: 26px; font-family: -app=
le-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif; font-size: 13px;"><li style=3D"box-sizing: bord=
er-box; margin: 0px; padding-bottom: 4px;">v3 approach</li></ol><p style=
=3D"box-sizing: border-box; margin-right: 0px; margin-left: 0px; padding-b=
ottom: 12px; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe U=
I&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;"=
>Placing commit_setup/commit_tail in rockchip_mode_config_helpers<br style=
=3D"box-sizing: border-box;">(shared by VOP and VOP2) with RK3588-only beh=
avior is acceptable from<br style=3D"box-sizing: border-box;">our perspect=
ive. The shared helpers already carry<br style=3D"box-sizing: border-box;"=
>drm_atomic_helper_commit_tail_rpm, so a thin RK3588 wrapper is the<br sty=
le=3D"box-sizing: border-box;">lesser evil compared to duplicating the com=
mit tail in the VOP2 driver.</p><p style=3D"box-sizing: border-box; margin=
-right: 0px; margin-left: 0px; padding-bottom: 12px; font-family: -apple-s=
ystem, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica N=
eue&quot;, sans-serif; font-size: 13px;">Looking forward to v3.</p><p styl=
e=3D"box-sizing: border-box; margin-right: 0px; margin-left: 0px; padding-=
bottom: 12px; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe =
UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;=
">[1]&nbsp;<a href=3D"https://lkml.indiana.edu/2311.1/06312.html" target=
=3D"_blank" rel=3D"noopener noreferrer" node=3D"[object Object]" style=3D"=
box-sizing: border-box; color: rgb(20, 112, 180); text-decoration-line: no=
ne; transition: color 0.15s ease 0s;">https://lkml.indiana.edu/2311.1/0631=
2.html</a><br style=3D"box-sizing: border-box;">[2]&nbsp;<a href=3D"https:=
//www.mail-archive.com/dri-devel@lists.freedesktop.org/msg626775.html" tar=
get=3D"_blank" rel=3D"noopener noreferrer" node=3D"[object Object]" style=
=3D"box-sizing: border-box; color: rgb(20, 112, 180); text-decoration-line=
: none; transition: color 0.15s ease 0s;">https://www.mail-archive.com/dri=
-devel@lists.freedesktop.org/msg626775.html</a><br style=3D"box-sizing: bo=
rder-box;">[3]&nbsp;<a href=3D"https://patchwork.kernel.org/project/dri-de=
vel/patch/20210707084745.1365390-11-maxime@cerno.tech/" target=3D"_blank" =
rel=3D"noopener noreferrer" node=3D"[object Object]" style=3D"box-sizing: =
border-box; color: rgb(20, 112, 180); text-decoration-line: none; transiti=
on: color 0.15s ease 0s;">https://patchwork.kernel.org/project/dri-devel/p=
atch/20210707084745.1365390-11-maxime@cerno.tech/</a></p><p style=3D"box-s=
izing: border-box; margin-right: 0px; margin-left: 0px; padding-bottom: 12=
px; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 13px;">Best reg=
ards,<br style=3D"box-sizing: border-box;">Boardcon Embedded Design<br sty=
le=3D"box-sizing: border-box;"><a href=3D"https://www.boardcon.com/" targe=
t=3D"_blank" rel=3D"noopener noreferrer" node=3D"[object Object]" style=3D=
"box-sizing: border-box; color: rgb(20, 112, 180); text-decoration-line: n=
one; transition: color 0.15s ease 0s;">https://www.boardcon.com</a></p></d=
iv>=0A</body></html>
------=_001_NextPart642481822616_=------


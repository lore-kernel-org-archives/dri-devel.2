Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D80C5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F47410E6C2;
	Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 17 Aug 2026 07:27:25 UTC
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com
 [115.124.28.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42077898F0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:27:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07756187|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0244448-0.00129075-0.974264;
 FP=8984393178044487325|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033040074035;
 MF=support@armdesigner.com; NM=1; PH=DS; RN=4; RT=4; SR=0;
 TI=SMTPD_---.iottaeb_1786951336; 
Received: from DESKTOP-F4DGRM2(mailfrom:support@armdesigner.com
 fp:SMTPD_---.iottaeb_1786951336 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 17 Aug 2026 15:22:17 +0800
Date: Mon, 17 Aug 2026 15:22:16 +0800
Organization: boardcon
From: support <support@armdesigner.com>
To: archive <archive@mail-archive.com>, 
 dri-devel <dri-devel@lists.freedesktop.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, 
 linux-rockchip <linux-rockchip@lists.infradead.org>
Subject: Re: RK3576: rockchip-pm-domain fw_devlink device-link failures for
 nested power-domain nodes
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.563[cn]
Mime-Version: 1.0
Message-ID: <202608171522158625086@armdesigner.com>
Content-Type: multipart/related;
 boundary="----=_001_NextPart101783873773_=----"
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

------=_001_NextPart101783873773_=----
Content-Type: multipart/alternative;
	boundary="----=_002_NextPart758307241703_=----"


------=_002_NextPart758307241703_=----
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64

SGkgU3ViYWlyLA0KV2UgaGF2ZSBlbmNvdW50ZXJlZCB0aGUgc2FtZSAiRmFpbGVkIHRvIGNyZWF0
ZSBkZXZpY2UgbGluayAoMHgxODApIiB3YXJuaW5ncyBhY3Jvc3Mgb3VyIFJvY2tjaGlwIEJTUCBk
ZXZlbG9wbWVudCwgbm90IG9ubHkgb24gUkszNTc2IGJ1dCBhbHNvIG9uIFJLMzU4OCBhbmQgUksz
NTY4LiBUaGlzIGlzIG5vdCBhbiBSSzM1NzYtc3BlY2lmaWMgRFRTIGlzc3VlLg0KQXMgU2ViYXN0
aWFuIFJlaWNoZWwgZXhwbGFpbmVkIGluIHRoZSBhY2NlbDogcm9ja2V0IE5QVSB0aHJlYWQgZWFy
bGllciB0aGlzIHllYXIgWzFdLCB0aGUgcm9vdCBjYXVzZSBpcyBhIGZ1bmRhbWVudGFsIGN5Y2xp
YyBkZXBlbmRlbmN5IGluIHRoZSBSb2NrY2hpcCBwb3dlci1jb250cm9sbGVyIGRyaXZlcjogdGhl
IFBNIGRvbWFpbiBjb250cm9sbGVyIG1heSBkZXBlbmQgb24gYSByZWd1bGF0b3Igc3VwcGxpZWQg
dmlhIEkyQywgd2hpbGUgdGhlIEkyQyBjb250cm9sbGVyIGl0c2VsZiBzaXRzIGluIGEgcG93ZXIg
ZG9tYWluIG1hbmFnZWQgYnkgdGhlIHNhbWUgY29udHJvbGxlci4gZndfZGV2bGluayBkZXRlY3Rz
IHRoaXMgY3ljbGUsIGdpdmVzIHVwLCBhbmQgcHJpbnRzIHRoZSB3YXJuaW5nLg0KRm9yIHRoZSBz
cGVjaWZpYyBwYXR0ZXJuIHlvdSBhcmUgc2VlaW5nIKGqIHdoZXJlIHRoZSBmYWlsZWQgc3VwcGxp
ZXIgaXMgInNvYyIgcmF0aGVyIHRoYW4gYW4gSTJDIFBNSUMgoaogdGhlIG1lY2hhbmlzbSBpcyBz
bGlnaHRseSBkaWZmZXJlbnQuIFRoZSBuZXN0ZWQgcG93ZXItZG9tYWluIGNoaWxkIG5vZGVzIChw
b3dlci1kb21haW5AMC9wb3dlci1kb21haW5AMSwgZXRjLikgYXJlIGNvbnN1bWVkIGludGVybmFs
bHkgYnkgcm9ja2NoaXBfcG1fYWRkX29uZV9kb21haW4oKSwgYnV0IGZ3X2RldmxpbmsgdHJlYXRz
IHRoZW0gYXMgcG90ZW50aWFsIGRldmljZXMuIEl0IHNlZXMgdGhlaXIgY2xvY2tzIHJlZmVyZW5j
ZXMgYW5kIGF0dGVtcHRzIHRvIGNyZWF0ZSBwcm94eSBkZXZpY2UgbGlua3MuIFNpbmNlIHRoZSBj
aGlsZCBmd25vZGVzIGhhdmUgbm8gYXNzb2NpYXRlZCBzdHJ1Y3QgZGV2aWNlLCB0aGUgbGlua3Mg
ZmFpbCBhbmQgZmFsbCBiYWNrIHRvIHRoZSBwYXJlbnQgKCJzb2MiKS4NClJlZ2FyZGluZyB5b3Vy
IHRocmVlIG9wdGlvbnM6DQpPcHRpb24gMiAoZHJpdmVyLWxldmVsIGZpeCkgaXMgdGhlIG1vc3Qg
cHJhY3RpY2FsIHBhdGguIEluIHJvY2tjaGlwX3BtX2RvbWFpbl9wcm9iZSgpLCBhZnRlciBwYXJz
aW5nIGVhY2ggY2hpbGQgbm9kZSB2aWEgcm9ja2NoaXBfcG1fYWRkX29uZV9kb21haW4oKSwgdGhl
IGRyaXZlciBjb3VsZCBtYXJrIHRoZSBjaGlsZCBmd25vZGUgd2l0aCBGV05PREVfRkxBR19OT1Rf
REVWSUNFLiBUaGlzIHRlbGxzIGZ3X2RldmxpbmsgdG8gc2tpcCBsaW5rIGNyZWF0aW9uIGZvciB0
aGF0IG5vZGUgYW5kIHdhbGsgdXAgdG8gdGhlIHBhcmVudCAocG93ZXItY29udHJvbGxlcikgZGV2
aWNlIGluc3RlYWQuIFNvbWV0aGluZyBsaWtlOg0KZm9yX2VhY2hfYXZhaWxhYmxlX2NoaWxkX29m
X25vZGUobnAsIG5wX2NoaWxkKSB7CiAgICAvKiAuLi4gZXhpc3RpbmcgZG9tYWluIHJlZ2lzdHJh
dGlvbiAuLi4gKi8KICAgIGZ3bm9kZV9zZXRfZmxhZygmbnBfY2hpbGQtPmZ3bm9kZSwgRldOT0RF
X0ZMQUdfTk9UX0RFVklDRSk7Cn0KDQpUaGlzIGlzIHRhcmdldGVkLCBkb2VzIG5vdCBhZmZlY3Qg
b3RoZXIgcGxhdGZvcm1zLCBhbmQgcmVxdWlyZXMgbm8gRFQgYmluZGluZyBjaGFuZ2VzLiBUaGUg
c2FtZSBhcHByb2FjaCBjb3VsZCBiZSBhcHBsaWVkIHJlY3Vyc2l2ZWx5IGZvciBuZXN0ZWQgc3Vi
LWRvbWFpbnMgKHBvd2VyLWRvbWFpbkAwL3Bvd2VyLWRvbWFpbkAxKS4NCk9wdGlvbiAxIChEVCBj
aGFuZ2UpIHdvdWxkIGJlIGZyYWdpbGUgoaogdGhlIERUIGJpbmRpbmcgYWxyZWFkeSBjb3JyZWN0
bHkgZGVzY3JpYmVzIHRoZSBwb3dlci1kb21haW4gdG9wb2xvZ3ksIGFuZCBhZGRpbmcgYSBub24t
c3RhbmRhcmQgYW5ub3RhdGlvbiBwcm9wZXJ0eSB3b3VsZCBiZSBhIHdvcmthcm91bmQgcmF0aGVy
IHRoYW4gYSBmaXguDQpPcHRpb24gMyAoT0YvZndfZGV2bGluayBjb3JlIGNoYW5nZSkgaXMgdGhl
IHByb3BlciBsb25nLXRlcm0gZml4IGJ1dCwgYXMgU2ViYXN0aWFuIG5vdGVkLCByZXF1aXJlcyBy
ZXN0cnVjdHVyaW5nIGhvdyB0aGUgUm9ja2NoaXAgcG93ZXItY29udHJvbGxlciBkcml2ZXIgcmVn
aXN0ZXJzIGl0cyBwcm92aWRlci4gVGhpcyBpcyB1bmxpa2VseSB0byBsYW5kIGluIHRoZSBuZWFy
IHRlcm0uDQpJbiBvdXIgcHJvZHVjdGlvbiBCU1BzIChSSzM1ODgvUkszNTY4KSwgd2UgaGF2ZSBi
ZWVuIHRyZWF0aW5nIHRoZXNlIHdhcm5pbmdzIGFzIGNvc21ldGljIKGqIHRoZSBhZmZlY3RlZCBk
b21haW5zIGZ1bmN0aW9uIGNvcnJlY3RseSBiZWNhdXNlIHJvY2tjaGlwX3BkX3Bvd2VyKCkgaGFu
ZGxlcyBkZXBlbmRlbmNpZXMgaW50ZXJuYWxseS4gSG93ZXZlciwgb24gUkszNTc2IHdpdGggaXRz
IGRlZXBlciBuZXN0aW5nIG9mIHBvd2VyLWRvbWFpbiBjaGlsZCBub2RlcywgdGhlIHZvbHVtZSBv
ZiB3YXJuaW5ncyBpcyBub3RpY2VhYmx5IGxhcmdlci4NCldlIHdvdWxkIGJlIGhhcHB5IHRvIHRl
c3QgYSBwYXRjaCBmb3Igb3B0aW9uIDIgb24gUkszNTg4LCBSSzM1NjgsIGFuZCBSSzM1NzYgaGFy
ZHdhcmUgaWYgc29tZW9uZSBwaWNrcyBpdCB1cC4NClsxXSBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9hcmNoaXZlcy9kcmktZGV2ZWwvMjAyNi1KdW5lLzU3MzgwMS5odG1sDQpCZXN0IHJl
Z2FyZHMsDQoNCk93ZW4NCg0KDQoNCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioNCkJvYXJkY29uIEVtYmVkZGVkIERlc2lnbg0KU2t5
cGU6IEJvYXJkY29uDQpUZWw6ICs4Ni0xMzUzNzY4NTg3OA0KRmF4OiA4Ni03NTUtMjc1NzE1NTIN
CkVtYWlsOiBzdXBwb3J0QGFybWRlc2lnbmVyLmNvbQ0KV2Vic2l0ZTogaHR0cDovL2FybWRlc2ln
bmVyLmNvbQ0Kd3d3LmJvYXJkY29uLmNvbQ0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KVGhpcyBtZXNzYWdlIChhbmQgYW55IGF0
dGFjaG1lbnRzKSBtYXkgY29udGFpbiBpbmZvcm1hdGlvbiB0aGF0IGlzIGNvbmZpZGVudGlhbCwg
cHJvcHJpZXRhcnksIHByaXZpbGVnZWQgb3Igb3RoZXJ3aXNlIHByb3RlY3RlZCBieSBsYXcuIFRo
ZSBtZXNzYWdlIGlzIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIG5hbWVkIGFkZHJlc3NlZShzKS4g
VW5sZXNzIHlvdSBhcmUgdGhlIGludGVuZGVkIGFkZHJlc3NlZShzKSwgYW55IGRpc3NlbWluYXRp
b24sIGRpc3RyaWJ1dGlvbiwgY29weWluZyBvciBkaXNjbG9zdXJlIG9mIHN1Y2ggaW5mb3JtYXRp
b24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBtZXNz
YWdlIGluIGVycm9yLCBwbGVhc2UgZGVsZXRlIGl0IGZyb20geW91ciBzeXN0ZW0gaW1tZWRpYXRl
bHkgYW5kIG5vdGlmeSB0aGUgc2VuZGVyLiBUaGFua3MhDQo=

------=_002_NextPart758307241703_=----
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DGB2312"><style>body { line-height: 1.5; }p { margin-top: 0px; margin-b=
ottom: 0px; }.fox_html_content_dummy_textarea { position: absolute; overfl=
ow: hidden; width: 1px; height: 1px; opacity: 0; }body { font-size: 14px; =
font-family: Arial; color: rgb(0, 0, 0); line-height: 1.5; }</style></head=
><body>=0A<div><span></span><p style=3D"box-sizing: border-box; margin-rig=
ht: 0px; margin-left: 0px; padding: 0px 0px 12px; font-size: 15.0001px; li=
ne-height: 1.786; font-family: -apple-system, BlinkMacSystemFont, &quot;Se=
goe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif;">Hi Subair,<=
/p><p style=3D"box-sizing: border-box; margin-right: 0px; margin-left: 0px=
; padding: 0px 0px 12px; font-size: 15.0001px; line-height: 1.786; font-fa=
mily: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &qu=
ot;Helvetica Neue&quot;, sans-serif;">We have encountered the same "Failed=
 to create device link (0x180)" warnings across our Rockchip BSP developme=
nt, not only on RK3576 but also on RK3588 and RK3568. This is not an RK357=
6-specific DTS issue.</p><p style=3D"box-sizing: border-box; margin-right:=
 0px; margin-left: 0px; padding: 0px 0px 12px; font-size: 15.0001px; line-=
height: 1.786; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe=
 UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif;">As Sebastian R=
eichel explained in the accel: rocket NPU thread earlier this year [1], th=
e root cause is a fundamental cyclic dependency in the Rockchip power-cont=
roller driver: the PM domain controller may depend on a regulator supplied=
 via I2C, while the I2C controller itself sits in a power domain managed b=
y the same controller. fw_devlink detects this cycle, gives up, and prints=
 the warning.</p><p style=3D"box-sizing: border-box; margin-right: 0px; ma=
rgin-left: 0px; padding: 0px 0px 12px; font-size: 15.0001px; line-height: =
1.786; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot=
;, Roboto, &quot;Helvetica Neue&quot;, sans-serif;">For the specific patte=
rn you are seeing =A1=AA where the failed supplier is "soc" rather than an=
 I2C PMIC =A1=AA the mechanism is slightly different. The nested power-dom=
ain child nodes (power-domain@0/power-domain@1, etc.) are consumed interna=
lly by rockchip_pm_add_one_domain(), but fw_devlink treats them as potenti=
al devices. It sees their&nbsp;<code class=3D"" style=3D"box-sizing: borde=
r-box; padding-inline: 4px; border-radius: 3px; background-color: rgba(0, =
0, 0, 0.05); pointer-events: none;">clocks</code>&nbsp;references and atte=
mpts to create proxy device links. Since the child fwnodes have no associa=
ted struct device, the links fail and fall back to the parent ("soc").</p>=
<p style=3D"box-sizing: border-box; margin-right: 0px; margin-left: 0px; p=
adding: 0px 0px 12px; font-size: 15.0001px; line-height: 1.786; font-famil=
y: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;=
Helvetica Neue&quot;, sans-serif;">Regarding your three options:</p><p sty=
le=3D"box-sizing: border-box; margin-right: 0px; margin-left: 0px; padding=
: 0px 0px 12px; font-size: 15.0001px; line-height: 1.786; font-family: -ap=
ple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvet=
ica Neue&quot;, sans-serif;"><span style=3D"box-sizing: border-box; font-w=
eight: 600;">Option 2 (driver-level fix) is the most practical path.</span=
>&nbsp;In rockchip_pm_domain_probe(), after parsing each child node via ro=
ckchip_pm_add_one_domain(), the driver could mark the child fwnode with FW=
NODE_FLAG_NOT_DEVICE. This tells fw_devlink to skip link creation for that=
 node and walk up to the parent (power-controller) device instead. Somethi=
ng like:</p><div class=3D"cb-markdown-pre-wrapper" style=3D"box-sizing: bo=
rder-box; padding-bottom: 12px; font-family: -apple-system, BlinkMacSystem=
Font, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
; font-size: 17.143px;"><div class=3D"cb-markdown-pre-container" style=3D"=
box-sizing: border-box; border-color: rgb(235, 235, 235); border-style: so=
lid; border-width: 0.8px; border-image: none 100% / 1 / 0 stretch; border-=
radius: 16px; overflow: hidden;"><pre class=3D"cb-markdown-pre" style=3D"b=
ox-sizing: border-box; margin-top: 0px; margin-bottom: 0px; border-top: no=
ne; overflow: auto; max-height: 60vh; padding: 12px 0px;"><code style=3D"b=
ox-sizing: border-box; display: block; margin-inline: 0px; border-radius: =
0px; background-color: inherit; color: rgb(59, 59, 59); overflow-x: auto; =
scrollbar-color: rgba(100, 100, 100, 0.4) rgba(0, 0, 0, 0); scrollbar-widt=
h: thin; font-size: 12.8573px; line-height: 1.75;">for_each_available_chil=
d_of_node(np, np_child) {=0A    /* ... existing domain registration ... */=
=0A    fwnode_set_flag(&amp;np_child-&gt;fwnode, FWNODE_FLAG_NOT_DEVICE);=
=0A}=0A</code></pre></div></div><p style=3D"box-sizing: border-box; margin=
-right: 0px; margin-left: 0px; padding: 0px 0px 12px; font-size: 15.0001px=
; line-height: 1.786; font-family: -apple-system, BlinkMacSystemFont, &quo=
t;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif;">This is=
 targeted, does not affect other platforms, and requires no DT binding cha=
nges. The same approach could be applied recursively for nested sub-domain=
s (power-domain@0/power-domain@1).</p><p style=3D"box-sizing: border-box; =
margin-right: 0px; margin-left: 0px; padding: 0px 0px 12px; font-size: 15.=
0001px; line-height: 1.786; font-family: -apple-system, BlinkMacSystemFont=
, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif;"><=
span style=3D"box-sizing: border-box; font-weight: 600;">Option 1 (DT chan=
ge)</span>&nbsp;would be fragile =A1=AA the DT binding already correctly d=
escribes the power-domain topology, and adding a non-standard annotation p=
roperty would be a workaround rather than a fix.</p><p style=3D"box-sizing=
: border-box; margin-right: 0px; margin-left: 0px; padding: 0px 0px 12px; =
font-size: 15.0001px; line-height: 1.786; font-family: -apple-system, Blin=
kMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif;"><span style=3D"box-sizing: border-box; font-weight: 600;">Opt=
ion 3 (OF/fw_devlink core change)</span>&nbsp;is the proper long-term fix =
but, as Sebastian noted, requires restructuring how the Rockchip power-con=
troller driver registers its provider. This is unlikely to land in the nea=
r term.</p><p style=3D"box-sizing: border-box; margin-right: 0px; margin-l=
eft: 0px; padding: 0px 0px 12px; font-size: 15.0001px; line-height: 1.786;=
 font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif;">In our production BSPs (RK35=
88/RK3568), we have been treating these warnings as cosmetic =A1=AA the af=
fected domains function correctly because rockchip_pd_power() handles depe=
ndencies internally. However, on RK3576 with its deeper nesting of power-d=
omain child nodes, the volume of warnings is noticeably larger.</p><p styl=
e=3D"box-sizing: border-box; margin-right: 0px; margin-left: 0px; padding:=
 0px 0px 12px; font-size: 15.0001px; line-height: 1.786; font-family: -app=
le-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif;">We would be happy to test a patch for option 2=
 on RK3588, RK3568, and RK3576 hardware if someone picks it up.</p><p styl=
e=3D"box-sizing: border-box; margin-right: 0px; margin-left: 0px; padding:=
 0px 0px 12px; font-size: 15.0001px; line-height: 1.786; font-family: -app=
le-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif;">[1]&nbsp;<a href=3D"https://lists.freedesktop.=
org/archives/dri-devel/2026-June/573801.html" target=3D"_blank" rel=3D"noo=
pener noreferrer" node=3D"[object Object]" style=3D"box-sizing: border-box=
; color: rgb(20, 112, 180); text-decoration-line: none; transition: color =
0.15s ease 0s;">https://lists.freedesktop.org/archives/dri-devel/2026-June=
/573801.html</a></p><p style=3D"box-sizing: border-box; margin-right: 0px;=
 margin-left: 0px; padding: 0px; font-size: 15.0001px; line-height: 1.786;=
 font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif;">Best regards,</p><p style=3D=
"box-sizing: border-box; margin-right: 0px; margin-left: 0px; padding: 0px=
; font-size: 15.0001px; line-height: 1.786; font-family: -apple-system, Bl=
inkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;=
, sans-serif;"><br></p><p style=3D"box-sizing: border-box; margin-right: 0=
px; margin-left: 0px; padding: 0px; font-size: 15.0001px; line-height: 1.7=
86; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
Roboto, &quot;Helvetica Neue&quot;, sans-serif;">Owen</p></div>=0A<div><br=
></div>=0A<hr style=3D"width: 210px; height: 1px;" align=3D"left" color=3D=
"#b5c4df" size=3D"1">=0A<div><span>=0A<div><div style=3D"font-family: 'Mic=
rosoft YaHei UI';"></div><div><p class=3D"MsoNormal" align=3D"left" style=
=3D"font-family: 'Times New Roman', serif; margin-right: 0cm; margin-left:=
 7.5pt; line-height: normal;"><b><span lang=3D"EN-US" style=3D"font-size: =
10pt; font-family: Verdana, sans-serif; color: navy;"><img border=3D"0" wi=
dth=3D"143" height=3D"71" id=3D"_x0000_i1025" src=3D"cid:_Foxmail.1@762497=
4a-966c-5e5b-8ba3-b2e37dc6b68a" style=3D"max-width: 100%; height: auto !im=
portant;"></span></b><span lang=3D"EN-US" style=3D"font-size: 10pt; font-f=
amily: Arial, sans-serif; color: navy;"><o:p></o:p></span></p><div style=
=3D"font-family: 'Microsoft YaHei UI', Tahoma; line-height: normal;"><div =
style=3D"position: static !important;"><div style=3D"position: static !imp=
ortant;"><p class=3D"MsoNormal" align=3D"left" style=3D"margin-right: 0cm;=
 margin-left: 7.5pt; font-size: 10.5pt; font-family: 'Times New Roman', se=
rif;"><span lang=3D"EN-US" style=3D"font-size: 10pt; font-family: Arial, s=
ans-serif; color: navy;">*************************************************=
************<o:p></o:p></span></p></div></div></div><p class=3D"MsoNormal"=
 align=3D"left" style=3D"margin-right: 0cm; margin-left: 7.5pt; line-heigh=
t: normal;"><b style=3D"background-color: transparent;"><span lang=3D"EN-U=
S" style=3D"color: navy; font-size: 12px;">Boardcon Embedded Design</span>=
</b></p><p class=3D"MsoNormal" align=3D"left" style=3D"margin-right: 0cm; =
margin-left: 7.5pt; line-height: normal;"><span style=3D"font-size: 12px;"=
><span lang=3D"EN-US" style=3D"color: navy;">Skype<b>: Boardcon</b></span>=
<span lang=3D"EN-US" style=3D"color: navy;"><br></span><span lang=3D"EN-US=
" style=3D"color: navy;">Tel: +86-13537685878<br>Fax: 86-755-27571552</spa=
n><b><span lang=3D"EN-US" style=3D"color: navy;"><o:p></o:p></span></b></s=
pan></p><p class=3D"MsoNormal" align=3D"left" style=3D"margin-right: 0cm; =
margin-left: 7.5pt; line-height: normal;"><span style=3D"font-size: 12px;"=
><span lang=3D"EN-US" style=3D"color: navy;">Email: <u>support</u></span><=
span lang=3D"EN-US"><a href=3D"mailto:M@armdesigner.com" style=3D"text-dec=
oration: none !important; color: purple;"><span style=3D"color: navy;">@ar=
mdesigner.com</span></a></span><u><span lang=3D"EN-US" style=3D"color: nav=
y;"><br></span></u><span lang=3D"EN-US" style=3D"color: navy;">Website:&nb=
sp;</span><span lang=3D"EN-US"><a href=3D"http://armdesigner.com/" style=
=3D"text-decoration: none !important; color: purple;"><span style=3D"color=
: navy;">http://armdesigner.com</span></a></span><span lang=3D"EN-US" styl=
e=3D"color: navy;"><o:p></o:p></span></span></p><p class=3D"MsoNormal" ali=
gn=3D"left" style=3D"margin-right: 0cm; margin-left: 7.5pt; line-height: n=
ormal;"><span lang=3D"EN-US"><a href=3D"http://www.boardcon.com/" style=3D=
"color: purple; text-decoration: none !important;"><span style=3D"color: n=
avy; font-size: 12px;">www.boardcon.com</span></a></span><span lang=3D"EN-=
US" style=3D"font-family: 'Microsoft YaHei UI'; font-size: 10pt; color: na=
vy;"><o:p></o:p></span></p><p class=3D"MsoNormal" align=3D"left" style=3D"=
margin-right: 0cm; margin-left: 7.5pt; line-height: normal;"><span lang=3D=
"EN-US" style=3D"font-size: 10pt; color: navy;"><font face=3D"Microsoft Ya=
Hei UI">*************************************************************</fon=
t></span><span lang=3D"EN-US" style=3D"font-family: Verdana, sans-serif; f=
ont-size: 10pt; color: navy;"><o:p></o:p></span></p><p class=3D"MsoNormal"=
 style=3D"margin-right: 0cm; margin-left: 7.5pt; text-align: justify; line=
-height: normal;"><span lang=3D"EN-US" style=3D"font-size: 7pt;">This mess=
age (and any attachments) may contain information that is confidential, pr=
oprietary, privileged or otherwise protected by law. The message is intend=
ed solely for the named addressee(s). Unless you are the intended addresse=
e(s), any dissemination, distribution, copying or disclosure of such infor=
mation is strictly prohibited. If you have received this message in error,=
 please delete it from your system immediately and notify the sender. Than=
ks!</span></p></div></div></span></div>=0A</body></html>
------=_002_NextPart758307241703_=------

------=_001_NextPart101783873773_=----
Content-Type: image/jpeg;
	name="InsertPic_E166.jpg"
Content-Transfer-Encoding: base64
Content-ID: <_Foxmail.1@7624974a-966c-5e5b-8ba3-b2e37dc6b68a>

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCABHAI8DASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD0Dxn4
xh8K2iKkYnvZwfKiJwAP7ze3868wn+IviqaUuNSEQPRI4UAH5g1J8RLiS48YXQkbIiAjUegGf8a5
cis+fU9qlhIqmm1qzfPxB8V/9Bd/+/Sf4U0/ELxZ/wBBh/8Av0n+Fc+RTSK2i0c9Sil0OhPxC8Wf
9Bh/+/Sf4Un/AAsPxZ/0GH/79J/hXPEU0iuiPL2OCcLHRf8ACxPFv/QYf/v0n+FdH4X+K98l7Ha+
IPLmt5CF+0ogVo/cgcEV5wRSEcVpyRatY5HzJn1GCGAIIIPIIpaxvB8z3HhDSpZGLObVMk98DFbN
cTVnY3QUUUUhhRRRQAUUUUAFFFFAHhfj0f8AFYX3+9XOEV0njz/kcL7/AHq5w1xc3vM+xp070Iei
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
QAUUUUAf/9k=

------=_001_NextPart101783873773_=------


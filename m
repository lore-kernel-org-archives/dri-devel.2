Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ED9C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9CE10E950;
	Tue, 25 Aug 2026 08:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="o/x0cRCL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA86710E950;
 Tue, 25 Aug 2026 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=From:Cc:To:Subject:MIME-Version:Date:Message-ID:Content-Type:
 From:Reply-To; bh=E5Yi9rWbJDggmSdZBp9jQ3UO3u4RRRWJQGEE9FIf1pI=; b=o/x0cRCLHLs
 4piZLZvUTPpQGvXstBWlRzwDpErQ411+lgxcu8t/5PzDrumOFsoth52y6HtfZG9+sR1sG0HoeLEbK
 WnCVY3N202DS8hH+V9lgabafF0XLYewBUk72AhZwo4Ly9p9PMSBTwxRIfIDnyL3EHdlG4nG+Q3JJB
 gUnaA9zxLp0ios4G/SsVASS8CfqCquBsS5ip+UAL40G1VAVU+cHRhoUBs5LvIO+sC9O/My4z2ERBu
 3wcXCeD6ISW4Xq/u7mqKFgJX3G6/oGCpF9AJe1v1U/HzqsOoORGc78wf4dq6MlDdjBzWKyHT9HqdK
 7C84SzfXmBA6aAlp+LCMQ9Q==;
Received: from 62-87-103-62.red-acceso.airtel.net ([62.87.103.62]
 helo=[10.121.51.20]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wymAo-008ukT-V7; Tue, 25 Aug 2026 10:06:23 +0200
Content-Type: multipart/mixed; boundary="------------K7O1Pu9oMXaLCJpSRKMd44AT"
Message-ID: <6faf80d8-2972-44a9-93f7-39ffee0d1fec@igalia.com>
Date: Tue, 25 Aug 2026 10:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
To: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, leandro.ribeiro@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
 <512414f0-ca55-435e-8ca3-7dbf48d0c114@freenet.de>
 <2b6f24cb-c387-4174-9e81-0a1a7ef42581@freenet.de>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <2b6f24cb-c387-4174-9e81-0a1a7ef42581@freenet.de>
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
--------------K7O1Pu9oMXaLCJpSRKMd44AT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/08/2026 23:02, Viktor Jägersküpper wrote:
> On 8/24/26 22:38, Viktor Jägersküpper wrote:
>> [ Adding Timur ]
>>
>> On 8/13/26 16:30, Melissa Wen wrote:
>>> DCE can support PREMULTI and COVERAGE blend mode depending on its
>>> generation, however current driver implementation either doesn't expose
>>> more than primary and cursor plane, or doesn't program registers for any
>>> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
>>> warning according to current DCE plane caps, create blend mode property
>>> with PIXEL_NONE only for primary planes, instead of the DRM default
>>> PREMULTI.
>>>
>>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>>> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>>>
>>> ---
>>> v3:
>>> - fix indentation (Alex H)
>>> ---
>>>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 +++++++++++-------
>>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> index ab9bbe8ca333..3b5b6943b67d 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> @@ -1923,14 +1923,18 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>>   	if (res)
>>>   		return res;
>>>   
>>> -	/* TODO: Check which blend modes are supported in DCE-generation
>>> -	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
>>> -	 * property accordingly.
>>> +	/* Blend mode support varies on DCE generations according to HW caps
>>> +	 * and number of planes per CRTC. However, as current driver
>>> +	 * implementation only creates one primary and one cursor plane per
>>> +	 * CRTC for DCE (overlay is only created if
>>> +	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode ends up
>>> +	 * being always PIXEL_NONE across DCE versions.
>>>   	 */
>>> -	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>>> -	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>>> -	    plane_cap && plane_cap->per_pixel_alpha &&
>>> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
>>> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
>>> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_NONE));
>>> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>>> +		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>>> +		   plane_cap && plane_cap->per_pixel_alpha) {
>>>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>>>   					  BIT(DRM_MODE_BLEND_COVERAGE);
>> With this patch applied to the mainline kernel, my display freezes when
>> Kwin is started (either by SDDM or by launching a KDE Plasma session).
>> GDM and Gnome work fine. The journal doesn't have much information, it's
>> mainly this:

I suspect KDE is not interpreting correctly the blend mode, but I think 
we can
keep it working as before by adding PREMULTI. In the end there is no overlay
plane for DCE, and PIXEL_NONE and PREMULTI are equivalent when one
primary is composed on top of a black background.

Can you replace this commit by the patch attached?
It might solve the issue as long as background continues being black.
I didn't apply it to drm-misc, so let me know how does this new patch works
on your side.

/cc Xaver to take a look at the KDE part.

Melissa

>>
>> kwin_wayland[8402]: Applying output configuration failed!
>>
>> and after that several KDE processes with:
>>
>> <kde_process>[xxxx]: There are no outputs - creating placeholder screen
>>
>> Any idea how I can debug this further? Maybe ask the KDE developers?
>>
>> With only the first two patches of this series applied, Kwin works as
>> before, but I get the warnings of course.
> I completely forgot that I'm observing this with AMD Pitcairn running
> KDE 6.7.4 on Arch Linux. The kernel is built from source (mainline as of
> today) with this patch series applied on top.
>
> Viktor

--------------K7O1Pu9oMXaLCJpSRKMd44AT
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amd-display-advertise-PIXEL_NONE-and-PREMULTI-bl.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amd-display-advertise-PIXEL_NONE-and-PREMULTI-bl.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5ZDA5N2RiNzBlZTJiY2ZhMzVkMzA3NjczYzkxYzM5ZjlkY2FkNWYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNZWxpc3NhIFdlbiA8bXdlbkBpZ2FsaWEuY29tPgpE
YXRlOiBUdWUsIDQgQXVnIDIwMjYgMTI6NDQ6MjggKzAyMDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kL2Rpc3BsYXk6IGFkdmVydGlzZSBQSVhFTF9OT05FIGFuZCBQUkVNVUxUSSBibGVu
ZCBtb2RlCiBmb3IgRENFCgpEQ0UgY2FuIHN1cHBvcnQgUFJFTVVMVEkgYW5kIENPVkVSQUdF
IGJsZW5kIG1vZGUgZGVwZW5kaW5nIG9uIGl0cwpnZW5lcmF0aW9uLCBob3dldmVyIGN1cnJl
bnQgZHJpdmVyIGltcGxlbWVudGF0aW9uIGVpdGhlciBkb2Vzbid0IGV4cG9zZQptb3JlIHRo
YW4gcHJpbWFyeSBhbmQgY3Vyc29yIHBsYW5lLCBvciBkb2Vzbid0IHByb2dyYW0gcmVnaXN0
ZXJzIGZvciBhbnkKYmxlbmQgbW9kZSBvdGhlciB0aGFuIFBJWEVMX05PTkUuIFRvIGZpeCB0
aGUgbWlzc2luZy1ibGVuZC1tb2RlLXByb3AKd2FybmluZyBhY2NvcmRpbmcgdG8gY3VycmVu
dCBEQ0UgcGxhbmUgY2FwcywgY3JlYXRlIGJsZW5kIG1vZGUgcHJvcGVydHkKd2l0aCBQSVhF
TF9OT05FIGFuZCBQUkVNVUxUSSBmb3IgcHJpbWFyeSBwbGFuZXMuIEFzIGxvbmcgYXMgdGhl
CmJhY2tncm91bmQgaXMgYmxhY2sgYW5kIHRoZXJlIGlzIG5vIG92ZXJsYXkgcGxhbmUsIFBJ
WEVMX05PTkUgYW5kClBSRU1VTFRJIGFyZSBlcXVpdmFsZW50LCBhbmQgUFJFTVVMVEkgaGFz
IGJlZW4gdGhlIG1hbmRhdG9yeS9kZWZhdWx0Cm1vZGUgZm9yIHllYXJzLCBzbyBrZWVwIGl0
IHRvIGF2b2lkIHJlZ3Jlc3Npb25zLgoKRml4ZXM6IDg2MGU3NDhiZGRjYyAoImRybTogZW5z
dXJlIGJsZW5kIG1vZGUgc3VwcG9ydGVkIGlmIHBpeGVsIGZvcm1hdCB3aXRoIGFscGhhIGV4
cG9zZWQiKQpSZXZpZXdlZC1ieTogTGVhbmRybyBSaWJlaXJvIDxsZWFuZHJvLnJpYmVpcm9A
Y29sbGFib3JhLmNvbT4gI3YyClNpZ25lZC1vZmYtYnk6IE1lbGlzc2EgV2VuIDxtd2VuQGln
YWxpYS5jb20+CgotLS0KdjM6Ci0gZml4IGluZGVudGF0aW9uIChBbGV4IEgpCnY0OgotIGFk
ZCBQUkVNVUxUSSB0byBhdm9pZCByZWdyZXNzaW9uIChyZXBvcnRlZCBieSBWaWt0b3IpCi0t
LQogLi4uL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcGxhbmUuYyAgIHwgMjQg
KysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcGxhbmUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BsYW5lLmMKaW5kZXggYWI5YmJlOGNhMzMz
Li40MDJmMGQzMzMxNTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BsYW5lLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcGxhbmUuYwpAQCAtMTkyMywxNCArMTky
MywyNCBAQCBpbnQgYW1kZ3B1X2RtX3BsYW5lX2luaXQoc3RydWN0IGFtZGdwdV9kaXNwbGF5
X21hbmFnZXIgKmRtLAogCWlmIChyZXMpCiAJCXJldHVybiByZXM7CiAKLQkvKiBUT0RPOiBD
aGVjayB3aGljaCBibGVuZCBtb2RlcyBhcmUgc3VwcG9ydGVkIGluIERDRS1nZW5lcmF0aW9u
Ci0JICogcGxhbmVzLCBpLmUuIERDX1BMQU5FX1RZUEVfRENFX1JHQi9VTkRFUkxBWSBhbmQg
ZXhwb3NlIGJsZW5kIG1vZGUKLQkgKiBwcm9wZXJ0eSBhY2NvcmRpbmdseS4KKwkvKiBCbGVu
ZCBtb2RlIHN1cHBvcnQgdmFyaWVzIG9uIERDRSBnZW5lcmF0aW9ucyBhY2NvcmRpbmcgdG8g
SFcgY2FwcworCSAqIGFuZCBudW1iZXIgb2YgcGxhbmVzIHBlciBDUlRDLiBIb3dldmVyLCBh
cyBjdXJyZW50IGRyaXZlcgorCSAqIGltcGxlbWVudGF0aW9uIG9ubHkgY3JlYXRlcyBvbmUg
cHJpbWFyeSBhbmQgb25lIGN1cnNvciBwbGFuZSBwZXIKKwkgKiBDUlRDIGZvciBEQ0UgKG92
ZXJsYXkgaXMgb25seSBjcmVhdGVkIGlmCisJICogRENfUExBTkVfVFlQRV9EQ05fVU5JVkVS
U0FMKSwgdGhlIHByaW1hcnkgcGxhbmUgYmxlbmQgbW9kZSBpcworCSAqIGlnbm9yZWQgYWNy
b3NzIERDRSB2ZXJzaW9ucy4gS2VlcCBQUkVNVUxUSSB0byBhdm9pZCB1QVBJCisJICogcmVn
cmVzc2lvbnM6IGl0IHdhcyB0aGUgZGVmYXVsdC9tYW5kYXRvcnkgbW9kZSBmb3IgbWFueSB5
ZWFycyBhbmQsCisJICogd2l0aCBubyBvdmVybGF5IHBsYW5lLCBwcmltYXJ5IGNvbXBvc2Vz
IG9uIHRvcCBvZiBhIGJsYWNrCisJICogYmFja2dyb3VuZCwgd2hlcmUgUFJFTVVMVEkgYW5k
IFBJWEVMX05PTkUgYXJlIGVxdWl2YWxlbnQuCiAJICovCi0JaWYgKChwbGFuZS0+dHlwZSA9
PSBEUk1fUExBTkVfVFlQRV9PVkVSTEFZIHx8Ci0JICAgICBwbGFuZS0+dHlwZSA9PSBEUk1f
UExBTkVfVFlQRV9QUklNQVJZKSAmJgotCSAgICBwbGFuZV9jYXAgJiYgcGxhbmVfY2FwLT5w
ZXJfcGl4ZWxfYWxwaGEgJiYKLQkgICAgcGxhbmVfY2FwLT50eXBlID09IERDX1BMQU5FX1RZ
UEVfRENOX1VOSVZFUlNBTCkgeworCWlmIChwbGFuZV9jYXAgJiYgcGxhbmVfY2FwLT50eXBl
ICE9IERDX1BMQU5FX1RZUEVfRENOX1VOSVZFUlNBTCkgeworCQl1bnNpZ25lZCBpbnQgYmxl
bmRfY2FwcyA9IEJJVChEUk1fTU9ERV9CTEVORF9QSVhFTF9OT05FKSB8CisJCQkJCSAgQklU
KERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKTsKKworCQlkcm1fcGxhbmVfY3JlYXRlX2JsZW5k
X21vZGVfcHJvcGVydHkocGxhbmUsIGJsZW5kX2NhcHMpOworCX0gZWxzZSBpZiAoKHBsYW5l
LT50eXBlID09IERSTV9QTEFORV9UWVBFX09WRVJMQVkgfHwKKwkJICAgIHBsYW5lLT50eXBl
ID09IERSTV9QTEFORV9UWVBFX1BSSU1BUlkpICYmCisJCSAgIHBsYW5lX2NhcCAmJiBwbGFu
ZV9jYXAtPnBlcl9waXhlbF9hbHBoYSkgewogCQl1bnNpZ25lZCBpbnQgYmxlbmRfY2FwcyA9
IEJJVChEUk1fTU9ERV9CTEVORF9QSVhFTF9OT05FKSB8CiAJCQkJCSAgQklUKERSTV9NT0RF
X0JMRU5EX1BSRU1VTFRJKSB8CiAJCQkJCSAgQklUKERSTV9NT0RFX0JMRU5EX0NPVkVSQUdF
KTsKLS0gCjIuNTMuMAoK

--------------K7O1Pu9oMXaLCJpSRKMd44AT--

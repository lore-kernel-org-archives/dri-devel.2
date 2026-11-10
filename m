Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9F606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ifEyezbl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6489810EEC3;
	Tue, 10 Nov 2026 09:15:13 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9B910EEC3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:15:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jP1Fg5HDmzMlJM;
 Tue, 10 Nov 2026 10:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794302103; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUcho8twJXgjwEPCrObhBW0yK1GzMc3JHr8xlFYANFg=;
 b=ifEyezbll62IWg9DTZIB0s+gg+zPNxe1+Kp1Rf78KBGc42LAxexW0xip9Outubiw3Qvpm7
 2v0yyclxsURvY9bMevENDIqiJi3OIIPb1fy2R6VUEW24jTz6ZMUlUjL6Paq43rAorSdtj0
 h7j04pMZ5UOo2PjZAis24aj6WRxJ881VynoDtwsH46HED4wvUFkAZeKbnzzJcvVM0XTUfv
 ZwEkNm8tJRVscRCFXVl8zgRA0pNb3zVfUPE7rq7rPbK4ViUXNQ4DDOLWb3kTTGPdDahDi1
 k/TwCUMdEO2E3yTIRhOhorwl9hH0QJky+GauJfgCHWloO75e5a53m9ZmE/rj2w==
Message-ID: <a887bbe998a3f0afeeb7fd955c6cafda67aa8fca.camel@mailbox.org>
Subject: Re: [PATCH 7/8] rust: drm: Add JobQueue
From: Philipp Stanner <phasta@mailbox.org>
To: Younes Akhouayri <git@younes.io>, Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl	 <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng	 <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Matthew Brost	
 <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Date: Tue, 10 Nov 2026 10:14:58 +0100
In-Reply-To: <kw-1794059738.215694434-299782-0@younes.io>
References: <20261106140752.520386-2-phasta@kernel.org>
 <20261106140752.520386-9-phasta@kernel.org>
 <kw-1794059738.215694434-299782-0@younes.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ouzy5xsma8ocp33pncyodapbeeh6zb8t
X-MBO-RS-ID: e0aa8df6102491b87ea
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTExLTA3IGF0IDEzOjU1ICswMDAwLCBZb3VuZXMgQWtob3VheXJpIHdyb3Rl
Ogo+IE9uIEZyaSwgNiBOb3YgMjAyNiAxNTowNzo1MiArMDEwMCwgUGhpbGlwcCBTdGFubmVyIHdy
b3RlOgo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJvcChqcSk7IC8vIFJlbGVh
c2UgbG9jay4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFQ6OnJ1bl9qb2Iod29yay5mY3R4
LCBydW5uYWJsZV9qb2IpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAganEgPSB3b3JrLmlu
bmVyLmxvY2soKTsgLy8gUmV0YWtlIGxvY2suCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvLyBydW5fam9iKCkgYWJvdmUgbmVlZHMgdG8gYmUgY2FsbGVkIHdpdGhvdXQgbG9jayBw
cm90ZWN0aW9uLiBUaHVzLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gaXQgaXMgcG9z
c2libGUgdGhhdCB0aGUgZHJpdmVyIGluc3RydWN0ZWQgY29tcGxldGlvbiByaWdodCBiZWZvcmUK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIHdlIGNvdWxkIHJlLXRha2UgdGhlIGxvY2su
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBqcS5sYXN0X2NvbXBsZXRlZCA+PSBzZXFu
byB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpqcS5hc19tdXQoKS5wcm9q
ZWN0KCkuY2FwYWNpdHkgKz0gdTY0Ojpmcm9tKGpvYi5jb3N0KTsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZmVuY2Uuc2lnbmFsKE9rKCgpKSk7Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIERyb3AgaGVyZSBkaXJlY3RseSBpZiBwb3NzaWJs
ZS4gT3RoZXJ3aXNlLCBsZXQgdGhlIERyb3BXb3JrZXIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLy8gdGFrZSBjYXJlIG9mIGl0Lgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiBjb3JlOjptZW06Om5lZWRzX2Ryb3A6OjxUOjpKb2JEYXRhVHlwZT4oKSB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAganEuZHJvcF9saXN0
LnB1c2hfYmFjayhqb2IpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBqcS5ydW5uaW5nX2pvYnMucHVzaF9iYWNrKGpvYik7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9Cj4gCj4gV2hlbiB0aGUgSVJRIHdpbnMgdGhlIHJhY2UsIGBjb21w
bGV0ZV9qb2JzX3VwX3RvX3NlcW5vKClgIGtpY2tzIHRoZQo+IERyb3BXb3JrZXIgYmVmb3JlIHRo
ZSBqb2IgbGFuZHMgb24gYGRyb3BfbGlzdGAsIGFuZCB0aGlzIGJyYW5jaAo+IHB1c2hlcyBpdCB0
aGVyZSB3aXRob3V0IGtpY2tpbmcgYWdhaW4uIEFtIEkgcmVhZGluZyBpdCByaWdodCB0aGF0IHRo
ZQo+IGpvYiB0aGVuIHNpdHMgb24gYGRyb3BfbGlzdGAgdW50aWwgdGhlIG5leHQgY29tcGxldGlv
biBvciB1bnRpbCB0aGUKPiBxdWV1ZSBkcm9wcz8gSWYgc28sIGlzIHRoYXQgYWNjZXB0YWJsZSwg
b3IgZG9lcyB0aGlzIHBhdGggbmVlZCBhCj4gYGNoZWNrX3N0YXJ0X2Ryb3Bfd29ya2VyKClgIHRv
bz8KCkkgdGVuZCB0byB0aGluayBpdCdzIGFjY2VwdGFibGUgKGFuZCBJIHdhcyBhd2FyZSBvZiB0
aGlzKS4gVGhvdWdoIHdlCmNvdWxkIGtpY2sgaXQgaGVyZSBuZXZlcnRoZWxlc3MsIGl0J3Mgbm8g
YmlnIGRlYWwuCgpARGFuaWVsLCB5b3UgbWVudGlvbmVkIGRyb3AgZGVsYXlzIHJlY2VudGx5LiBP
cGluaW9uPwoKPiAKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLndpdGhfaW5uZXIofGlubmVy
fCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZXQgbXV0IGlubmVyID0gaW5uZXIubG9j
aygpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGV0IGRyb3BfbGlzdCA9IGNvcmU6Om1l
bTo6dGFrZSgmbXV0IGlubmVyLmRyb3BfbGlzdCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBsZXQgd2FpdGluZ19qb2JzID0gY29yZTo6bWVtOjp0YWtlKCZtdXQgaW5uZXIud2FpdGluZ19q
b2JzKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxldCBtdXQgcnVubmluZ19qb2JzID0g
Y29yZTo6bWVtOjp0YWtlKCZtdXQgaW5uZXIucnVubmluZ19qb2JzKTsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxlIGxldCBTb21lKGpvYikgPSBydW5uaW5nX2pvYnMucG9w
X2Zyb250KCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZXQgZmVuY2Ug
PSBqb2IuZmVuY2UuYXNfcmVmKCkuZXhwZWN0KCJmZW5jZSBub3QgcHJlc2VudCIpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmZW5jZS5zaWduYWwoRXJyKHNlbGYuZXJyKSk7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkcm9wKGlubmVyKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRyb3AoZHJv
cF9saXN0KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRyb3Aod2FpdGluZ19qb2JzKTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRyb3AocnVubmluZ19qb2JzKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoCB9KQo+IAo+IEluIHRoZSBgd2hpbGUgbGV0IFNvbWUoam9iKSA9IHJ1bm5pbmdf
am9icy5wb3BfZnJvbnQoKWAgbG9vcCwgYGpvYmAKPiBnb2VzIG91dCBvZiBzY29wZSBhdCB0aGUg
ZW5kIG9mIGVhY2ggaXRlcmF0aW9uLCB3aGlsZSBgaW5uZXJgIGlzCj4gc3RpbGwgbG9ja2VkLiBJ
ZiBgSm9iRGF0YVR5cGVgIGhhcyBhIGBEcm9wYCBpbXBsLCB0aGF0IGVuZHMgdXAgaW4KPiBgRHJp
dmVyRmVuY2U6OmRyb3BgIC0+IGBzeW5jaHJvbml6ZV9yY3UoKWA7IHNvIGlzIHNsZWVwaW5nIHRo
ZXJlIHdpdGgKPiB0aGUgaXJxIHNwaW5sb2NrIGhlbGQgaW50ZW5kZWQsIG9yIHNob3VsZCB0aG9z
ZSBqb2JzIGJlIGNvbGxlY3RlZCBhbmQKPiBkcm9wcGVkIGFmdGVyIGBkcm9wKGlubmVyKWAgbGlr
ZSBgZHJvcF9saXN0YCBhbmQgYHdhaXRpbmdfam9ic2AgYXJlPwoKTm9wZSwgdGhhdCBjb2RlIGlz
IHdyb25nISBBY3R1YWxseSwgbm90IGhvbGRpbmcgdGhlIGxvY2sgaXMgZXZlbiB0aGUKcmVhc29u
IHdoeSB0aGUgbWVtOjp0YWtlIGlzIGRvbmUuCgpJIGFkZGVkIHRoZSBsb29wIGxhdGVyLiBXaGF0
IGx1cmVkIG1lIGludG8gaXQgaXMsIEkgdGhpbmssIHRoYXQKY29tcGFyZWQgdG8gQyB5b3UgY2Fu
bm90IGNsZWFybHkgc2VlIHRoZSB1bmxvY2soKS4gTm90IHN1cmUgaWYgdGhhdCdzCmlkaW9tYXRp
YyBhbmQgaW50ZW5kZWQsIGJ1dCBJIGxpa2UgdG8gY2FsbCBzdWNoIHZhcmlhYmxlcwpgaW5uZXJf
bG9ja2VkYCBvciBhZGQgYSBjb21tZW50IHNvIHRoYXQgaXQncyBjbGVhcmx5IHZpc2libGUgdGhh
dCBhbgp1bmxvY2sgdGFrZXMgcGxhY2UuCgpXaWxsIGZpeCwgdGhhbmsgeW91LgoKUC4K


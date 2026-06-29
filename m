Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B542C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489C410E137;
	Mon, 29 Jun 2026 21:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="blLZGisB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F0310E137
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782768754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XB7pqHpgq/nQnB1tGmENNG6g651KvMQ7dydjVpfr+Y=;
 b=blLZGisB/IxYi+yCROb5D7vd5+fHkTLNOwO7XTf1tCup8p0nNvuiVqQ5LE+2gK93t4/M8f
 P7hH8cLFiRcY5NDK54P+TiBHDF5fwUiPaOemp2uL0NARg48l9zBLJgd4UzMmqaBuYElm4+
 dS3MSz7PU9cBXK+shwnwCOXUl7K3zP8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-a2mF6hasOaKOHUN1ydqbZQ-1; Mon, 29 Jun 2026 17:32:32 -0400
X-MC-Unique: a2mF6hasOaKOHUN1ydqbZQ-1
X-Mimecast-MFC-AGG-ID: a2mF6hasOaKOHUN1ydqbZQ_1782768752
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ee593a5a2fso58842066d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782768752; x=1783373552;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CSRk1nqmk8ToNWejBPUj18Gym2Ng80mr6qO9hwj2XTo=;
 b=TAVffbkdNKj0trbx5DkAAYlBDOU1j99BgIPkxUxAQfatcwlpEGKAlJhwVEFS8hptG7
 ZQXbE7y50Wpu6e4xfA+yAqsGaa8I2LmRa9iz0za72lR3i7ScnQVzZDhEkzdxCrtGVmnV
 Ti8VLI8MBhu5i1BfDqf9/YS4EisqygwqlgjlNme4lxzHbRgP+D4qxS7jqam4JAf9+EwJ
 RlkI80ku3cRBv1ZjtUvJoTyXbFcNr+gtBZol8XnVT7eo172x7jRRZq9XXu75cSGy6XRT
 777BQWtl7WyXmNrTrSh9XUw4gBuVJrZn93Cy/0Dj+23mN/eIK7bQReu9SAoEakM3oHGO
 L6Aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIT0OxdHwRg0tmMxBAnzp4t/hAGwqcszzNDSa/KAMDEFhbV22bdHwcrqlXJxzUSFgIgHxWpNld5CQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlhDG0qQIm3dglVBX0hPGgdSNz3nCcNDFFHznlkMdf4qIFuoe0
 DXWsw1K2PNz2T/wWxkAhTKcapSZ2VnrFa+vii5Pv1GtjlVcsg6PYJx+VukBNNmv9IrH7XkqF3DI
 ZsF+rc1+T0J6q6ph9bjlecQD8mqd6q5RmTqAP/GUSLXujTvVKbAdx3seyzGuyimBOk1+sMw==
X-Gm-Gg: AfdE7cl4Wow/rr/AAzAikMV+kh4aWDqvHugsqygNH4Tiq8qzwZefACOVbl/MBDda7q0
 9vnHoH3Fj/7XYrgZoWwRZL6SqA9uxT99CXleMFm9xjL8rMdlJzjrXP6Z9KVtW3s0B3islrWcDpQ
 AxrC9RjSmFmKPUC1MUswxqR6M2/G0Wq0gL/7z40YzpbKKRy0YdFxeP8bBhhX3UUwqCQ5nyMyh67
 x6LBgHSAMfBHJ0y6CqWPpQOoex6ZS6vWnCDIaREhrNKIhiufU/CwIVur8dwacxM7Rrma0nv1rAx
 oz4fNiErKvRSrXhB85uZ8xAKmsWmZalY9rkfuGE3enZvjBJ7oQF1fOpLLtfp5P4Lo9Zqc6tggpf
 wpZER1Io=
X-Received: by 2002:ad4:4eab:0:b0:8ee:d9b8:8538 with SMTP id
 6a1803df08f44-8f1bc95fc6emr16241626d6.9.1782768751854; 
 Mon, 29 Jun 2026 14:32:31 -0700 (PDT)
X-Received: by 2002:ad4:4eab:0:b0:8ee:d9b8:8538 with SMTP id
 6a1803df08f44-8f1bc95fc6emr16241016d6.9.1782768751191; 
 Mon, 29 Jun 2026 14:32:31 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a7b2699dsm7151196d6.46.2026.06.29.14.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:32:30 -0700 (PDT)
Message-ID: <24195bd1807ba2b47b80a30050d12ec010ba4f1f.camel@redhat.com>
Subject: Re: [PATCH v5 01/19] rust: drm: ioctl: fix unbounded lifetimes in
 ioctl handler arguments
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com, 
 daniel.almeida@collabora.com, acourbot@nvidia.com, ecourtney@nvidia.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, 	lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, 	deborah.brouwer@collabora.com,
 boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Mon, 29 Jun 2026 17:32:29 -0400
In-Reply-To: <20260628145406.2107056-2-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-2-dakr@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zK2_nurPZ2vV6WtbFPCp1bmPfR314_uztf54HbsN_OY_1782768752
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
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

dGhpcyBtYWNybyBpcyB3aWxkLgoKUmV2aWV3ZWQtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhh
dC5jb20+CgpPbiBTdW4sIDIwMjYtMDYtMjggYXQgMTY6NTMgKzAyMDAsIERhbmlsbyBLcnVtbXJp
Y2ggd3JvdGU6Cj4gUmVmZXJlbmNlcyB0byBkZXYsIGRhdGEsIGFuZCBmaWxlIGluIHRoZSBkZWNs
YXJlX2RybV9pb2N0bHMhIG1hY3JvCj4gYXJlCj4gY3JlYXRlZCB2aWEgdW5zYWZlIHBvaW50ZXIg
ZGVyZWZlcmVuY2VzLCBwcm9kdWNpbmcgdW5ib3VuZGVkCj4gbGlmZXRpbWVzLgo+IElmIGFuIGlv
Y3RsIGhhbmRsZXIgZXhwbGljaXRseSBhbm5vdGF0ZXMgaXRzIHBhcmFtZXRlcnMgd2l0aCAnc3Rh
dGljLAo+IHRoZSBjb21waWxlciBhY2NlcHRzIHRoaXMsIGFsbG93aW5nIHRoZSBoYW5kbGVyIHRv
IHN0YXNoIHJlZmVyZW5jZXMKPiB0aGF0Cj4gb3V0bGl2ZSB0aGUgaW9jdGwgY2FsbC4KPiAKPiBG
aXggdGhpcyBieSBhZGRpbmcgYSBoaWdoZXItcmFua2VkIGZ1bmN0aW9uIHBvaW50ZXIgY29lcmNp
b24gdGhhdAo+IGVuZm9yY2VzIHRoZSBoYW5kbGVyIGFjY2VwdHMgdW5pdmVyc2FsbHkgcXVhbnRp
ZmllZCBsaWZldGltZXM6Cj4gCj4gwqAgbGV0IF86IGZvcjwnYT4gZm4oJidhIF8sICYnYSBtdXQg
XywgJidhIF8pIC0+IF8gPSAkZnVuYzsKPiAKPiBTaW5jZSB0aGUgaGFuZGxlciBtdXN0IGJlIGNv
ZXJjaWJsZSB0byBhIGZ1bmN0aW9uIHBvaW50ZXIgYWNjZXB0aW5nCj4gYW55Cj4gbGlmZXRpbWUg
J2EsIGl0IGNhbiBubyBsb25nZXIgZGVtYW5kICdzdGF0aWMgb24gYW55IHBhcmFtZXRlci4KPiAK
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IEZpeGVzOiA5YTY5NTcwNjgyYjEgKCJydXN0
OiBkcm06IGlvY3RsOiBBZGQgRFJNIGlvY3RsIGFic3RyYWN0aW9uIikKPiBSZXBvcnRlZC1ieTog
c2FzaGlrby1ib3RAa2VybmVsLm9yZwo+IENsb3NlczoKPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNjA2MjAwMTEzNDYuQTQ3RDAxRjAwMEU5QHNtdHAua2VybmVsLm9yZy8KPiBTdWdn
ZXN0ZWQtYnk6IEdhcnkgR3VvIDxnYXJ5QGdhcnlndW8ubmV0Pgo+IFNpZ25lZC1vZmYtYnk6IERh
bmlsbyBLcnVtbXJpY2ggPGRha3JAa2VybmVsLm9yZz4KPiAtLS0KPiDCoHJ1c3Qva2VybmVsL2Ry
bS9pb2N0bC5ycyB8IDYgKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
Cj4gCj4gZGlmZiAtLWdpdCBhL3J1c3Qva2VybmVsL2RybS9pb2N0bC5ycyBiL3J1c3Qva2VybmVs
L2RybS9pb2N0bC5ycwo+IGluZGV4IGNmMzI4MTAxZGRlNC4uY2NmNDE1MGQ4M2I2IDEwMDY0NAo+
IC0tLSBhL3J1c3Qva2VybmVsL2RybS9pb2N0bC5ycwo+ICsrKyBiL3J1c3Qva2VybmVsL2RybS9p
b2N0bC5ycwo+IEBAIC0xMzUsNiArMTM1LDEyIEBAIG1hY3JvX3J1bGVzISBkZWNsYXJlX2RybV9p
b2N0bHMgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8vIGRldi9maWxlIG1hdGNoIHRoZSBjdXJyZW50IGRyaXZlcgo+IHRoZXNlIGlv
Y3RscyBhcmUgYmVpbmcgZGVjbGFyZWQKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvLyBmb3IsIGFuZCBpdCdzIG5vdCBjbGVhciBob3cg
dG8KPiBlbmZvcmNlIHRoaXMgd2l0aGluIHRoZSB0eXBlIHN5c3RlbS4KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZXQgZGV2ID0KPiAk
Y3JhdGU6OmRybTo6ZGV2aWNlOjpEZXZpY2U6OmZyb21fcmF3KHJhd19kZXYpOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIEVu
Zm9yY2UgdGhhdCB0aGUgaGFuZGxlciBhY2NlcHRzCj4gaGlnaGVyLXJhbmtlZAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gbGlmZXRp
bWVzLCBwcmV2ZW50aW5nIGl0IGZyb20KPiByZXF1aXJpbmcgJ3N0YXRpYwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gcmVmZXJlbmNl
cyB0aGF0IGNvdWxkIGVzY2FwZSB0aGlzCj4gc2NvcGUuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZXQgXzogZm9yPCdhPiBmbigmJ2Eg
XywgJidhIG11dCBfLCAmJ2EKPiBfKSAtPiBfID0gJGZ1bmM7Cj4gKwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIFNBRkVUWTogVGhl
IGlvY3RsIGFyZ3VtZW50IGhhcyBzaXplCj4gYF9JT0NfU0laRShjbWQpYCwgd2hpY2ggd2UKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
LyBhc3NlcnRlZCBhYm92ZSBtYXRjaGVzIHRoZSBzaXplIG9mCj4gdGhpcyB0eXBlLCBhbmQgYWxs
IGJpdCBwYXR0ZXJucyBvZgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8vIFVBUEkgc3RydWN0cyBtdXN0IGJlIHZhbGlkLgoNCg==


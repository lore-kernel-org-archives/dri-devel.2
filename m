Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F7010BA445
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D935E10E39B;
	Fri, 27 Mar 2026 08:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fe4lSNJV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD4B10E389;
 Fri, 27 Mar 2026 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774600428; x=1806136428;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=5JnJZVcTjUsDSvNnmfQ12zXxh0K+BGs/g23rZJ9gsDU=;
 b=Fe4lSNJVt8BOc9bYhH2PuH2lb+O1oYl78arGhGAYKlRp8XTDND5cmnSA
 h3vuQK5W8WO0K/nFJYTejuGocg0S6iIpLW65nWpt0zLl/HwUh1np9vMYx
 2Muv4kJoQ5rbjQ25TDSkqmAHKWZ8sEeGA+35kVhav83bClvex7rJBUuIR
 utU5Pwc/plJz0wNXFAiM/pBb0U5RH6sBj+63E/aoKsLakyh4qIGWnZyhR
 hfPt7hOoHa20jd/yTb4Z2Ywngd4U7t2np4VR1KClH8/B3JM2D+LuClzKU
 Kg5z3ecu2d0e+wiigc0qQmX9pG9Jo3FgjaVONmC6L+S35OGXUGk9BfHAq w==;
X-CSE-ConnectionGUID: A5fIHw1wSJi+xTLxFgaXbQ==
X-CSE-MsgGUID: oEgWjM53RF+Vzgzrr7AI2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75573796"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75573796"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:33:47 -0700
X-CSE-ConnectionGUID: QhWVA9BUQomeBkzKdmxjMw==
X-CSE-MsgGUID: Qu3pQTu7Q2yL7+QQ6ISDKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="225504790"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.146])
 ([10.245.244.146])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:33:43 -0700
Message-ID: <065a48aa13d94cd52d8df38dabe0d955108a615a.camel@linux.intel.com>
Subject: Re: [PATCH 0/5] Add reclaim to the dmem cgroup controller
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner
 <hannes@cmpxchg.org>,  Tejun Heo <tj@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 	cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie	 <airlied@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Fri, 27 Mar 2026 09:33:39 +0100
In-Reply-To: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDA5OjE1ICswMTAwLCBUaG9tYXMgSGVsbHN0csO2bSB3cm90
ZToKPiBXaGVuIHdyaXRpbmcgYSAibWF4IiBsaW1pdCBsb3dlciB0aGFuIHRoZSBjdXJyZW50IHVz
YWdlLCB0aGUKPiBleGlzdGluZyBjb2RlIHNpbGVudGx5IGZhaWxlZC4gVGhpcyBzZXJpZXMgYWlt
cyB0byBpbXByb3ZlCj4gb24gdGhhdCBieSByZXR1cm5pbmcgLUVCVVNZIG9uIGZhaWx1cmUgYW5k
IGFsc28gYXR0ZW1wdAo+IHRvIHN5bmNocm9ub3VzbHkgcmVjbGFpbSBkZXZpY2UgbWVtb3J5IHRv
IHB1c2ggdGhlIHVzYWdlCj4gdW5kZXIgdGhlIG5ldyBtYXggbGltaXQgdG8gYXZvaWQgdGhlIGVy
cm9yLgo+IAo+IFBhdGNoIDEgaW1wbGVtZW50cyBlcnJvciBwcm9wYWdhdGlvbi4KPiBQYXRjaCAy
IGltcGxlbWVudHMgYW5kIGRvY3VtZW50cyBhIHJlY2xhaW0gY2FsbGJhY2sgaW50ZXJmYWNlCj4g
wqDCoMKgwqDCoCBmb3IgdGhlIGRtZW0gY29udHJvbGxlci4KPiBQYXRjaCAzIGltcGxlbWVudHMg
YSBUVE0gcmVjbGFpbSBjYWxsYmFjay4KPiBQYXRjaCA0LTUgaG9va3MgdXAgdGhlIHJlY2xhaW0g
Y2FsbGJhY2sgdG8gdGhlIGRtZW0gY2dyb3Vwcy0KPiDCoMKgwqDCoMKgIGF3YXJlIGRyaXZlcnMg
eGUgYW5kIGFtZGdwdS4KPiAKPiBUaG9tYXMgSGVsbHN0csO2bSAoNSk6Cj4gwqAgY2dyb3VwL2Rt
ZW06IFJldHVybiBlcnJvciB3aGVuIHNldHRpbmcgbWF4IGJlbG93IGN1cnJlbnQgdXNhZ2UKPiDC
oCBjZ3JvdXAvZG1lbTogQWRkIHJlY2xhaW0gY2FsbGJhY2sgZm9yIGxvd2VyaW5nIG1heCBiZWxv
dyBjdXJyZW50Cj4gdXNhZ2UKPiDCoCBkcm0vdHRtOiBIb29rIHVwIGEgY2dyb3VwLWF3YXJlIHJl
Y2xhaW0gY2FsbGJhY2sgZm9yIHRoZSBkbWVtCj4gwqDCoMKgIGNvbnRyb2xsZXIKPiDCoCBkcm0v
eGU6IFdpcmUgdXAgZG1lbSBjZ3JvdXAgcmVjbGFpbSBmb3IgVlJBTSBtYW5hZ2VyCj4gwqAgZHJt
L2FtZGdwdTogV2lyZSB1cCBkbWVtIGNncm91cCByZWNsYWltIGZvciBWUkFNIG1hbmFnZXIKPiAK
PiDCoGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uY8KgwqDCoMKgwqAgfMKg
wqAgMiArLQo+IMKgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMg
fMKgIDEwICstCj4gwqBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDk1ICsrKysrKysrKysrKysrKystCj4gwqBkcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9ib191dGlsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0K
PiDCoGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Jlc291cmNlLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMzYgKysrKysrKwo+IMKgZHJpdmVycy9ncHUvZHJtL3hlL3hlX3R0bV92cmFtX21nci5j
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMTkgKystLQo+IMKgaW5jbHVkZS9kcm0vdHRtL3R0bV9iby5o
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTAgKysKPiDCoGlu
Y2x1ZGUvZHJtL3R0bS90dG1fcmVzb3VyY2UuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgNCArCj4gwqBpbmNsdWRlL2xpbnV4L2Nncm91cF9kbWVtLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMSArKwo+IMKga2VybmVsL2Nncm91cC9kbWVtLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMDIgKysrKysr
KysrKysrKysrKy0KPiAtLQo+IMKgMTAgZmlsZXMgY2hhbmdlZCwgMjY1IGluc2VydGlvbnMoKyks
IDI3IGRlbGV0aW9ucygtKQoKRm9yIHJlZmVyZW5jZSwgU2VyaWVzIGludHJvZHVjaW5nIGlndCB0
ZXN0IGlzIGhlcmU6Cmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMTYz
OTM1LwoKL1Rob21hcwo=


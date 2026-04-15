Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B2FFA0C29
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C64210E0E3;
	Wed, 15 Apr 2026 05:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MuHfL7Kr";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873F110E0E3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:08:37 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8a032383008so71775716d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 22:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776229716; x=1776834516; darn=lists.freedesktop.org;
 h=references:in-reply-to:subject:cc:to:from:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=acWqE1tc4Ow5F1BA+F7RH5Eqve12kgs/16bnXdFmrs8=;
 b=MuHfL7KrQNWu/uGdkLlrVINcM0Ciu/3ebTWBvogatQ1rNSjYrUd2ya4hkAeEOtSB1d
 qaAXUH9/3u3Iqcw5Wnfv+6XgUaWoIim/jUZ7VZnngw/IQZcUdP46nzsBJnWuHH7lTlZE
 bPXaBDyn0t1yZKfI2Q86nHcwjgZprSFDAXGfb+OjPacqrsLsyiMN0gePN8qyvC+Hj3p/
 a5WZIHnlFUe0I69rjudUZBVwvuUi5U8r1Wk87sOTOuyue3LFOVseKu/hm8WWPGZnLJXv
 1cI+3YeBYiXklm5ADWRyXoN554//F2NvVRVVflQdOcwvCsmBJL8I9ahZmDJ7A9qGQBZn
 gw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776229716; x=1776834516;
 h=references:in-reply-to:subject:cc:to:from:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acWqE1tc4Ow5F1BA+F7RH5Eqve12kgs/16bnXdFmrs8=;
 b=YkFZ2WJH3qypICfPlkHpoQLa5hwMdL4EXN64dDurnShgZdeaDIFQ1neUekXmHhERV5
 LE/mbH6indw4NHQDsyIo/1bqFoWfSYAjI4Ur4AGUu7taK77bXy/TFe39zW5Wx9tpEe2J
 YDnYnjbq079FZYXRf0GxirIjcXmQuy1JSQ1OLqUxDnyuybSABCc+AvaOl/Paeuk2fOE/
 Uq+2+Aityakbxcsa+jxNVFVMSoJltQPrw+8YbdViY3tigXD4b7dhnTxlUV372xE3HMwz
 khsT6mKXN4P4gwFUqFWGulvGdbKFlgohSEd01HS8JC3lHrUrWPmdvHUXoN5ucSuwzQQM
 tsRg==
X-Gm-Message-State: AOJu0YwjGpRN7UDEW8NhemtnwkSwv7l5tu/1QgB7Hl/MHqgEoprexnVo
 0Cjh/jhjiaf8euj0dAiGQ+wkGHWfZDKHfBEkkUpXW2H4ro4RTq4YKIEC
X-Gm-Gg: AeBDiet09Y19MGpnr/0FYqio0bCwtIzzllD55n3umT4gha2Jl2Bs3Q7IfVfiBMY7GTu
 ZVzsVTujs/5XPowyZeOfvjZ5LPGaTqqAT1fn/gSe2e/VsLwnJyZw1LWBVs5n57zxJWpm1/eVT0U
 PzCTwdJ7UBsOc8UbYqgKvB4jLCy6QPHIq0fVXBiUZD8gTQ8M0/hdNG/eKvrkKY7ipMLfqdvDI20
 xkzkYMjVPyEJA8XELSpTtXoNeLYcByc+u6oARGGwdUPjv55tV3iHQZl7KN/t/4OhcFwpWdMzShG
 nasUOvlPjRKeCvMchnka1GrSqJ6z1ldPh2ySgXvIYX5Q+dHV1Yl9joaifYmFnN3GlEfdOQV7KHT
 L88+VzqdBT+F6M1ZxRdc7C3tGj7YLwZ+EKBRNIZDGwCmnqAj5rPxd7pjg3C9E6xUr1GhLTrjnQg
 uwSmU02WCf+C3eRm9AF4gxcvMB+X4sgCLmktgWlb6WFMSEzTBFDun/eGFWwz19jaVUn5Je6iI=
X-Received: by 2002:a05:6214:3986:b0:8ac:b2b2:b2f0 with SMTP id
 6a1803df08f44-8acb2b2c5bdmr156438416d6.1.1776229716413; 
 Tue, 14 Apr 2026 22:08:36 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c993a3asm3944476d6.22.2026.04.14.22.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 22:08:36 -0700 (PDT)
Message-ID: <69df1d54.050a0220.153b60.b34d@mx.google.com>
Date: Tue, 14 Apr 2026 22:08:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5011019757784256419=="
MIME-Version: 1.0
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org, itoral@igalia.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/v3d: Reject empty multisync extension to prevent
 infinite loop
In-Reply-To: <8c2f4d80-2f33-4cd1-a6f0-ac5f23cdb777@igalia.com>
References: <8c2f4d80-2f33-4cd1-a6f0-ac5f23cdb777@igalia.com>
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

--===============5011019757784256419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGkgTWHDrXJhLAoKT24gMTQvMDQvMjYgMTE6MDcsIE1hw61yYSBDYW5hbCB3cm90ZToKPiBMR1RN
LCBidXQgdGhlIGluZGVudGF0aW9uIGxvb2tzIG9mZiB0byBtZSAodjEgYW5kIHYyIHdlcmUgY29y
cmVjdCkuCj4gQ291bGQgeW91IGNoZWNrIGlmIHRoZXJlIGlzIGFueSBpc3N1ZSB3aXRoIHlvdXIg
ZS1tYWlsIGNsaWVudD8KClNlbnQgdjQgd2l0aCB0aGUgaW5kZW50YXRpb24gZml4ZWQuIFNvcnJ5
IGZvciB0aGUgbm9pc2UhCgpCZXN0IHJlZ2FyZHMsCkFzaHV0b3No

--===============5011019757784256419==--

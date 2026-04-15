Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D53F8A148
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF8E10E852;
	Thu, 16 Apr 2026 08:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="mSOHcSs+";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B5910E736
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:08:31 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-50d6ab4476eso73212571cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1776280110;
 x=1776884910; darn=lists.freedesktop.org; 
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2ZD7dT4mPOvwMbi0OBxIJnAUIwzJXsBdIr9I4x9bzE=;
 b=mSOHcSs+5qzI0iV0wY/cXYIImNMRQAE/14J5fYvcyvu1OBxFKMJyXfUWzYI95dxs/g
 PksVp79Ozhf9EFy9v35rUj1pePwpu8iyw8haPFPSN1SKOp+28l4xpTeCQuSIrgCYEEYc
 T2rlHTDV8BZI8YQAoAaWXhx2aLv+hdGYVUMFgLNbF9BPhPSJ337oWtwEmkE4tzQTKDzH
 aTb3FV4VYBIs4+BGDyrxfoArEdtRg7psk1GEHVBU7LGEfjcndouhAvNfftkhLrPpwHDc
 2irEK6KMy3nol4N+PvP6loqX792KgOvZwTW6GTVPs0BKlfn/4ALrdWwg/0vWPM+MQV2k
 P2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776280110; x=1776884910;
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2ZD7dT4mPOvwMbi0OBxIJnAUIwzJXsBdIr9I4x9bzE=;
 b=k0MmCNxP7rS/NBQ9lFCtjca8phz/1CCEiCrcmLy6Jnva1bkNqoY6zbvxMP7Wg0QJ6O
 BsoUGxwcRm/D3yIFtDuQac8YFzT5xpSOwMvUWwsRqGfTRTjkQORJQsUhdGvW6Se6ZeXu
 5Pvzg19darBb8TPSOXnr/JbDBTnCNwiFSokyKQGweW+gfi1ISzvLAADmVY/CJJ4EB1hi
 mR8qIxNIuk7q38Z9vqcm2p3FskIl8chLMiJ9KQEhMzN1pvfbuOqIBj54gKkFBG+72joH
 oWFzNhuLtCaMaC1SoR4ZVxOfMgY5DIQwTt6X678siin9/n9O6VcAHZya7uy41WpMlTmB
 hkdw==
X-Gm-Message-State: AOJu0YxiPLjJG17CRg07iKwIfBuKF0JzIDK7lFDM9LnhR7s5E9JEMlUm
 tEEo4pAI+cFRPoVKinBpwP8Y9HIOyYeeE5JIuQtMkeFIXFMxY3mzYlB008IzYwX3q+A43Zzq15v
 7YlMneIM=
X-Gm-Gg: AeBDieu5Cul8aN8Cvh/K5FbckXdC3MIuIQKfW+Wrj0nlVOIc02wjGQS8CMJmoxdVXgv
 26RmcnTf/7TP7J78ORK7dXlPyg3S6Jr+tOIXZlDrQ3WKOdd5ALdzM6GU/OimanONP5m4bGrm1zR
 CVP+26FwN3/ewoD8igT0xxMNfoA92PsANtbYusbJxc+nbRcWlvtAyBTWEuzPy9O8xd/TNyzw03T
 gPNneJxPz7BeE415W7i4lY7Y3mTLaiyPh98TvtZbr1ivnlMyRbclIpOg4uJiOuzMlltgPTcjjjh
 bSuFL4a8HMcoTgoQehIdwVRNBrv9lwC51Rpbo7/23pJWI7O35Hn9F8XF/5wmMZmZefvsmHXbNv0
 7HdO4OB1BRnBqa3h6MkZ9JQBn7W4ldba0MRNbmkvP5HoWKJ+zFr4v8YdXeZnsLwKqOny2vxFJrK
 hdC6spoUI8KUWdKuxIwmeKAgzE0Bv4mtIozVD7vzq1DArCkS5CNAUh6TpCjPt6f0dD6eiwBjNRN
 d0AJwbxp0zDq4/27mU1CzBIZcJUidJWy5hoFRLXQT8=
X-Received: by 2002:a05:622a:15c5:b0:50b:48de:5448 with SMTP id
 d75a77b69052e-50dd5ad0a9amr342111341cf.6.1776280110104; 
 Wed, 15 Apr 2026 12:08:30 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:e5:500:8e39:827f:e928:9eb7])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e1faf1c34sm16720911cf.13.2026.04.15.12.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:08:29 -0700 (PDT)
Message-ID: <69dfe22d.050a0220.60470.81b5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Jake S <j@metarealtyinc.ca>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com
Subject: Re: [PATCH 0/2] drm: Enable eDP VRR for panels with DisplayID
 Adaptive Sync
In-Reply-To: <20260415130626.10523-1-j@metarealtyinc.ca>
References: <20260415130626.10523-1-j@metarealtyinc.ca>
Date: Wed, 15 Apr 2026 19:08:28 +0000
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

SGkgVmlsbGUsCgo+IFdoeSBkaWQgeW91IHBvc3QgYSBkaWZmZXJlbnQgdmVyc2lvbj8KClNvcnJ5
IGZvciB0aGUgY29uZnVzaW9uIC0tIEkgd2Fzbid0IGJ1aWxkaW5nIG9uIEFkcmlhbm8gVmVybydz
Ck1hcmNoIDI4IHBhdGNoLiBJIGRpZCB0aGUgaW52ZXN0aWdhdGlvbiBpbmRlcGVuZGVudGx5IGFu
ZCBvbmx5IGZvdW5kCmhpcyB3b3JrIGFmdGVyd2FyZHMuIEkgcmVmZXJlbmNlZCBpdCBpbiB0aGUg
Y292ZXIgbGV0dGVyIGJ1dCBzaG91bGQKaGF2ZSBiZWVuIGNsZWFyZXIuCgpUaGUga2V5IGRpZmZl
cmVuY2U6IEFkcmlhbm8ncyBwYXRjaCBoYW5kbGVzIHRhZyAweDI1IChEeW5hbWljIFZpZGVvClRp
bWluZyBSYW5nZSBMaW1pdHMpLiBNeSBwYW5lbCAoTEcgRGlzcGxheSBWTkZUMiBpbiBhIERlbGwg
WFBTIDIwMjYpCm9ubHkgaGFzIHRhZyAweDJCIChBZGFwdGl2ZSBTeW5jIERhdGEgQmxvY2spLCBz
byBoaXMgcGF0Y2ggYWxvbmUKd291bGRuJ3QgaGF2ZSBoZWxwZWQgaGVyZS4gTXkgcGF0Y2ggaGFu
ZGxlcyBib3RoIDB4MkIgYW5kIDB4MjUuCgpIYXBweSB0byBjb29yZGluYXRlIHdpdGggQWRyaWFu
byBhbmQgZm9sZCB0aGUgMHgyQiBoYW5kbGluZyBpbnRvIGEKdjIgb2YgaGlzIHNlcmllcyBpZiB0
aGF0J3MgcHJlZmVycmVkLgoKVGhhbmtzLApKYWtlCg==

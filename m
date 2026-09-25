Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF20EC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D401510F916;
	Fri, 25 Sep 2026 07:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZsbR5AWy";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA39210E216
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 01:06:42 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4ab2029eso517279d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790298401; cv=none;
 d=google.com; s=arc-20260327;
 b=ZTNUUxeCjPwlZkk/3WiRSLVQu4+aYMB82uZ0UiIYdnq/4WBN5s2sr/AjKh3Me5/ypT
 vmql22plxW+6fPljGP0EwrfKniv9U6mPznG37j9gKU8Z36XXZynE0fu+QmAJA/S6Iwy6
 myoHdJLR0NeY8sMWnRLwZRIjOoznGU6AnM8uwUGNzVqdonhqWQv+f6sexQrFvkhkp0kR
 xlqQCLF7o5RPtgxqFa2w2G8IGwa1cMDqaOyQaG2TfQSXDZQxbE5aRv2LHwY3EwJR9Tk3
 jid/ZnfG/loppUQr1yme2XJG+oj5z3vl0Sidrz+trAGvGyd7zo5TCOUFv74vi+7MXQj+
 0SLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0UWWegM3zaySSImGAmVuG25fiwQNAAHUhoXGTbOrN78=;
 fh=9GDLYrDP8FWecc4hT0utHXxfweav+PD2e1YyPSwCxSg=;
 b=nF57EdBksYyhj0ZrGB1CQdw+btZJIflJb+9ki6DgN1HdkVi83+Zm+EDPapdn3FaMx6
 iuOXiSCzU36CsyGkx1VbO3zlUVxxujOB2WTKsjDpsEsVnG/IBTzVeiV3oz9wdYmXZ1/t
 ea9HSLKCydhnqoc2Sqf+qDU7dnJ4Rg4WePnkXpLZEEXWBNarawpDUFMppgt7LWRCVqOj
 +xkhGY7YDth8HmNrIx1MawXSg8ICtbzvubIrtAzPeD2WwATwJR/PBmXnaY63b+ZP2ycP
 Hfb/0DukgWembX37tiTdHVOZj75/9hfK/snrpu+SOTQwXHD8k7HnuWJSijE9z2rIjHhL
 hG+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790298401; x=1790903201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0UWWegM3zaySSImGAmVuG25fiwQNAAHUhoXGTbOrN78=;
 b=ZsbR5AWygCEQGHUEa6qAtQM1Nj+Ihv0dvo5lgZOLp8KqY+v4HQEdyY/dMN1tuYOyf+
 D5EIKU6M6v+SRw9MMPfTmx0HZ6/mx2d0tvs0OYAEasg95DLIRyurVhQnlPV9FaLiJk6i
 OIUK7WH8LKC3tlOrZmET/95gb/FNsEOmSoyTMdvKvX6BsQUY3PrP3svcb8c9aUMtjkEq
 AgbuOeH3+aPnUo7FQbLjMJqQX+ywGBcsA6QJjT6bEodNTjNEGu4s7yN1KNK3+6WYPcBA
 j5af4634hyBgG+4Qf7m5whRT7Fa1t6+vMxz3+K+ZTHaHW7IyN3qSy8SYAsLpxD8XAdC+
 zymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790298401; x=1790903201;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0UWWegM3zaySSImGAmVuG25fiwQNAAHUhoXGTbOrN78=;
 b=xl7G1QHLncKYIW6AIhcoroq4yHLtj3vUIOATl4tfRc6Y3VemVYcUs+wuCNMAzm/pZi
 7fcYDQ33xWNiQezOGau4uYC/G5knTXNnJIll2hSxLCax1JUf3QA69UL21s72ce8VyiSW
 1MvmtBsDrGTHIm1drUpFw7M/egwacNUdJQXKPvE6EX7u2LV5XNviIxrlp7YGW15jPwlR
 /cfxNzMR/FIyeXeoSAgo/j4zyLr5RHtSfmtSv89Y4RfGxp22JIDel6gulbHMicI54Wdf
 CbNEHlljURAWN74YVWyMs0Nabc3FB8z3M1PMwk2/WGbN9dhAiDrqYPDIhpr2JqLqbnkY
 NGIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzsW6DfEIAXlE+aaTGOlO9b2IgV/NO1O4UJtppGIztghz3jjWGpWh8lE1YlaJgsedbvRVBL/h2O0I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lKsOhZAaeSFpkY3FMBaChowprkYktLHYBNezHwfz1xzsKCXalI
 4jpEmdd/KQW5SvL+3GAGo1/njbZAFD8rSI/UQJ1AMYaDW4ocG/3UJ/PKQJ5JGUsFQ7llxRo7XW7
 SyV3IsNcPVEPm0P1TodNIQ/NEQUinpDA=
X-Gm-Gg: AYBFou0WUA3NEll9/oh6vnTcd9FJuW4oD8rNxR7DwWW6HSLOiyCc7GScKpmOLfm6DKc
 od1sFdop6vvx4c3wLsttD/0sxtwUE9kYhQGDS87oKtco9fQ205jbGJU1ZxRYrJPstCoe4S/dO+K
 VdhkRwVRTfviF/rkqzLE7IRX+yP0LhDsarUMt4R4FnWlMgSAmch+b6lxpPmQuaycVXjUNQOVgHm
 Zkk3252/IuxG94G4Mwn57CBtP/RBXT9WM6CU7k6a++WTbcSRQN6sM0MuRTy4dphkpae3lji9UW5
 1IUxIZ1h8PPbHgbdopbarFvsPAHCri/N6MhnJ8/uFBMI+pBiCwfA/5BDJXyDNRc5uKyR5JBVWut
 mPcPkC/GgITZN/jVqVhTHLNeBHAiVzrNgPOzcTFx7h1Q=
X-Received: by 2002:a05:690e:1343:b0:672:99e1:11f4 with SMTP id
 956f58d0204a3-672ed523ab0mr1807170d50.145.1790298401392; Thu, 24 Sep 2026
 18:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260922144634.55130-1-talesam@gmail.com>
 <arWenmbBkCZ4m7I8@gsse-cloud1.jf.intel.com>
In-Reply-To: <arWenmbBkCZ4m7I8@gsse-cloud1.jf.intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Thu, 24 Sep 2026 22:06:30 -0300
X-Gm-Features: AclHuK-r4LLIiBiR1RGrRY3Sys7ZN1PZp4qyLo2evLQzPzAw5UlLUytrsT3CmrE
Message-ID: <CAHBRX4EnQ2W1XxzZjnqZfQS0cG7V4PNB_47s5dHnX6T8N5CiCA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, daniele.ceraolospurio@intel.com, 
 stuart.summers@intel.com, julia.filipchuk@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 jani.nikula@intel.com, navonjohnlukose@gmail.com, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

Thanks Matt, and thanks everyone for the reviews and the testing.

Tales

--=20
Tales A. Mendon=C3=A7a
talesam.org | communitybig.org

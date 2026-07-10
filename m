Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FBDC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8199A10F801;
	Fri, 10 Jul 2026 08:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="mClY73mw";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306E410F801;
 Fri, 10 Jul 2026 08:01:38 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7mJlo4024913; Fri, 10 Jul 2026 08:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TRuwl8
 6BGWpU1jU8guWAWBH8ZYVteU8GtSs4ecwEwWc=; b=mClY73mweHu5ygEi9BG5GP
 C0Ku4aPCymlqXbMQVpPqdi1OGQ4em6CUOBfNKkuZQoKSn1hAdszLX9S+EEpeqdKo
 RItd6Eay1jiYW9QHiHGqA6neUhkdKaAnKDxr61b6TRm2i7esjA4Q/CW0T/Kx32kC
 +BHtFelrZt1VsM66Xi6FxMsydCGfgfBmvWHRQmQ9iy69vdxCNOXBnv/ysD+bub91
 /b/vD/bFhX4D+0VEjnaVgEIamRIJH+ZvjJ0V3N+HlH1fHrP5kqhKas19c+nfTHYQ
 jueBM4ZvhP17ECp7bmxuQhqoss2yfk73sL8FPg9Aol3HvnFC4eILtH7BKRw/RB2A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke5wjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 08:01:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A7oVtj015623;
 Fri, 10 Jul 2026 08:01:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwh7rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 08:01:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66A81Shq29491918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 08:01:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 488A45805F;
 Fri, 10 Jul 2026 08:01:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D87158063;
 Fri, 10 Jul 2026 08:01:23 +0000 (GMT)
Received: from [9.61.248.61] (unknown [9.61.248.61])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 08:01:23 +0000 (GMT)
Message-ID: <14e618d3-34ea-4bc9-b9a8-3783e2b61e0a@linux.ibm.com>
Date: Fri, 10 Jul 2026 13:31:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: amdgpu_dm_plane_test.ko fails to
 build due to modpost "too long symbol"
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
 bhawanpreet.lakha@amd.com
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 george.zhang@amd.com, bhawanpreet.lakha@amd.com,
 LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, broonie@kernel.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>, alex.hung@amd.com
References: <fde3656e-9e22-4e4c-937f-7e8cb918da6b@linux.ibm.com>
 <54f6efe8-cab8-4fc8-bf00-f012b3224e54@infradead.org>
 <85931e07-60eb-4df2-bc52-773c63f27f6c@linux.ibm.com>
In-Reply-To: <85931e07-60eb-4df2-bc52-773c63f27f6c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50a6da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=e5mUnYsNAAAA:8 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=SLFSCceQY6lPwsTqLRcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX0AAz39XYJ6br
 n52g+n7Uo0O666+XoQaqT01MESVilyVfzB9EckxfkLdYYhrmdgDknmzSQEEw/KIxGXXKqBtsB/t
 dGGV0mEOq6Cmbvylx+JSoldV37g/rw+CT3LQRzuDeVokTtdCVfGkRs00pVx3HtLj5lHY1EjLsNu
 5VZYmRipvW/dM9iMAQy2j90mtwYBL+NOUTx3K9esWwQ2aI6rRkXDPWXzejPjJRS19NkDRgKLJWx
 AUw7aZF4oC3imGw2mQySKp4fX9gusais46kLZn6YPhZ5yGtj1YJk5udZjE+5cW5RfmClt3kpZGp
 9+jKJlcUuOJvE0NJmr0JPgsPptIjERblN6WlYL2CEl4uzftyTicDblolJxgrLowwZIDZ9cGUWA/
 25DdxQ8NZEXcsNU8OqMUGG8oPLEpj1MOHrjc6BqSQ380cPh6gbW6csel6BVMxyYaUh8Xm3kKQDS
 tXs6X2gQ1wS2+o0XCiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX4zeUO8LDexsE
 LK91sct/bPYvGcJlWMIUXQOTWmvZ7kZVyRXT3N8y6difVQNfCag8hiMAszJiuw2Aur1iWXBYIHb
 IHTPoG3+zRq2x3spELlG9FZAvfmXFpM=
X-Proofpoint-GUID: uZ-waZZZpH3XZhpfD9ErbABEoYWmFnVG
X-Proofpoint-ORIG-GUID: uZ-waZZZpH3XZhpfD9ErbABEoYWmFnVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100074
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


On 10/07/26 10:45 am, Venkat Rao Bagalkote wrote:
>
> On 09/07/26 11:53 pm, Randy Dunlap wrote:
>>
>> On 7/7/26 10:05 PM, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>> linux-next is failing to build for me with:
>>>
>>> ERROR: modpost: too long symbol
>>> "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
>>> [drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_plane_test.ko] 
>>>
>>>
>>> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>> make[1]: *** [Makefile:2165: modpost] Error 2
>>> make: *** [Makefile:248: __sub-make] Error 2
>>>
>>> The failure occurs during modpost while building:
>>>
>>> drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.ko
>>>
>>> This appears to be a regression in the AMD display KUnit test code.
>>>
>>> Could someone please take a look?
>>>
>>>
>>> If you happen to fix this, please add below tag.
>>>
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Hi,
>> I cannot reproduce this when using gcc v15.3.0.
>>
>> Which compiler & version are you using?
>>
> Hello,
>
> I am seeing this across below mentioned gcc version.
>
>
> gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4)
> gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-11)
> gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-7)
>
>
> Attched is the .config file.

Git bisect is pointing to below commit as first bad commit.


# git bisect bad
2b147895be109e0860269a7a72c697cdf049a885 is the first bad commit
commit 2b147895be109e0860269a7a72c697cdf049a885 (HEAD)
Author: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Date:   Fri Jun 12 16:12:21 2026 -0400

     drm/amd/display: Add kunit tests for amdgpu_dm_plane

     Add kunit tests for some functions in amdgpu_dm_plane.

     Assisted-by: Copilot:Claude-Opus-4.8
     Reviewed-by: Alex Hung <alex.hung@amd.com>
     Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
     Signed-off-by: George Zhang <george.zhang@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  115 
++++++-----
  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   51 +++++
  drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile  |    2 +
  drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 
1204 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  4 files changed, 1325 insertions(+), 47 deletions(-)
  create mode 100644 
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c


# git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [5c73cd9f0819c1c44e373e3dabb68318b1de1a12] Add linux-next 
specific files for 20260707
git bisect bad 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
# good: [8cdeaa50eae8dad34885515f62559ee83e7e8dda] Linux 7.2-rc2
git bisect good 8cdeaa50eae8dad34885515f62559ee83e7e8dda
# good: [aac7863446a8e0cf380f4a5087bc3cdc9b8c14c0] Merge branch 'master' 
of https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good aac7863446a8e0cf380f4a5087bc3cdc9b8c14c0
# bad: [fe28d02cde5372d7f71cc6132ccdef37a98ac750] Merge branch 
'for-linux-next' of https://gitlab.freedesktop.org/drm/i915/kernel.git
git bisect bad fe28d02cde5372d7f71cc6132ccdef37a98ac750
# good: [0639cb26862afe4e35a689a8b5df8b9117c19f52] Merge tag 
'drm-xe-next-2026-07-03' of https://gitlab.freedesktop.org/drm/xe/kernel 
into drm-next
git bisect good 0639cb26862afe4e35a689a8b5df8b9117c19f52
# good: [4e9c8a9c322427055c4892183d266ba391af1bc8] drm/amdkfd: drop 
struct kfd_signal_page wrapper
git bisect good 4e9c8a9c322427055c4892183d266ba391af1bc8
# bad: [ea33aa1545535fdb4c1a208b7bfd63314c3a4aa2] drm/amdgpu: Drop 
legacy ACA log RAS error data code
git bisect bad ea33aa1545535fdb4c1a208b7bfd63314c3a4aa2
# good: [a17e79d01f22182a9fcbe79fcbe2ad1477d43e0f] drm/amd/pm: Validate 
pp_table header before reading size
git bisect good a17e79d01f22182a9fcbe79fcbe2ad1477d43e0f
# bad: [7a561c2b1b63abcffb55f625c0d0adb68ab2961a] drm/amd/display: 
Simplify boolean checks
git bisect bad 7a561c2b1b63abcffb55f625c0d0adb68ab2961a
# good: [53ef33c084c5778cc2dcd1efff25e31b6e231141] drm/amd/pm: Validate 
Tonga PPTable subtable bounds
git bisect good 53ef33c084c5778cc2dcd1efff25e31b6e231141
# good: [fe5966d4fdcbed91e6b3478ea6c89d9915d6ed4a] drm/amdkfd: move 
TBA/TMA from system to device memory
git bisect good fe5966d4fdcbed91e6b3478ea6c89d9915d6ed4a
# good: [7a39b1c3b2e6b27f4230a20ccf9ac5a2737fa8b0] drm/amd/display: 
Replace repeated no-native-i2c checks with force_i2c_over_aux field
git bisect good 7a39b1c3b2e6b27f4230a20ccf9ac5a2737fa8b0
# good: [88ae862060f05cd8279e764832f04eafafa505d8] drm/amd/display: Add 
more KUnit tests for amdgpu_dm_colorop
git bisect good 88ae862060f05cd8279e764832f04eafafa505d8
# bad: [2b147895be109e0860269a7a72c697cdf049a885] drm/amd/display: Add 
kunit tests for amdgpu_dm_plane
git bisect bad 2b147895be109e0860269a7a72c697cdf049a885
# first bad commit: [2b147895be109e0860269a7a72c697cdf049a885] 
drm/amd/display: Add kunit tests for amdgpu_dm_plane

>
>
> Regards,
>
> Venkat.

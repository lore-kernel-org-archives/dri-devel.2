Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84CFC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B8410F038;
	Thu, 23 Jul 2026 09:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="EzLL8GfC";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8226C10E55D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZcT/VxjN0F4msUWYtL7coF3T0xj8dg48+ECR/YZSs8Q=; b=EzLL8GfCOSvv9yNSOBVPhfTq5v
 9cMUTihMRqgmFfqJxTrkbqChuaZ0/X+kwCzFVMwLZCE1ywgy54Rgd2QMVwY8rr71gnbbIgIt578B5
 0nBpbZQB2H2WPssHtlAz5DaEKLnVI3m0shGAWDnmkLU2bz4ZtpVwIXp9LjaHLQcfoHnOMe+dKPUaG
 hw3wEQO/YSZRnQdvuqZq724lpGO0Cuja3eFPvIcTAwUawMj1aAcZF5dTUY4vHv5jPpIBmf+4XH2hn
 ug9SjTr5zTWKu7z2/3TEQmht5Joi+bx4ZBrYXqmPG/mD+7yK9rpaRhwxR222z9Iu/APq0FB3tYvim
 ZvWYrXAQ==;
Received: from [2001:8b0:10b:5:4d19:522c:231a:3cdb]
 (helo=u09cd745991455d.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wmpun-000000009LE-3vhV; Thu, 23 Jul 2026 09:40:30 +0000
Message-ID: <1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org>
Subject: Re: [RFC PATCH v2 00/11] KVM: Allow alternative providers of
 guest_memfd backed by PFNMAP memory
From: David Woodhouse <dwmw2@infradead.org>
To: Ackerley Tng <ackerleytng@google.com>, Sean Christopherson	
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org,  Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Thomas
 Gleixner	 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jason Gunthorpe
 <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,  Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Tom Lendacky <thomas.lendacky@amd.com>, Tycho
 Andersen <tycho@kernel.org>, Kees Cook <kees@kernel.org>,  Ashish Kalra
 <ashish.kalra@amd.com>, Connor Williamson <connordw@amazon.com>, Andrew
 Morton	 <akpm@linux-foundation.org>, Zhou Yuhang <zhouyuhang@kylinos.cn>,
 Zi Li	 <zi.li@linux.dev>, Dan Williams <djbw@kernel.org>, Eric Biggers	
 <ebiggers@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
 connordw@amazon.co.uk, graf@amazon.de, fgriffo@amazon.co.uk
Date: Thu, 23 Jul 2026 10:40:27 +0100
In-Reply-To: <CAEvNRgG-K2HOJoMmdMSH0gEuLNhgX2tqUAakoRqEx6noNyU3vg@mail.gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <CAEvNRgG-K2HOJoMmdMSH0gEuLNhgX2tqUAakoRqEx6noNyU3vg@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-LbQdAGc+FXJ85CtJAqQg"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa9~24.04 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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


--=-LbQdAGc+FXJ85CtJAqQg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-22 at 17:24 -0700, Ackerley Tng wrote:
> David Woodhouse <dwmw2@infradead.org> writes:
>=20
> > For dedicated hosting environments, there are a few reasons to prefer
> > using external PFNMAP memory for guests, rather than kernel-managed
> > memory:
> >=20
> > =C2=A0=E2=80=A2 No struct page overheads
> >=20
> > =C2=A0=E2=80=A2 Easily managed in 1GiB pages (or larger chunks); no fra=
gmentation/THP
> >=20
> > =C2=A0=E2=80=A2 Faster kexec/KHO live update (every millisecond spent f=
affing around
> > =C2=A0=C2=A0 with memory management is an extra millisecond of steal ti=
me taken
> > =C2=A0=C2=A0 from guests)
> >=20
>=20
> Also, no need to split/merge pages when converting from private to
> shared if the host mappings can't depend on the refcounts in struct
> pages :).
>=20
> > Today, there is only one implementation of guest_memfd: the internal
> > shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
> > for other code to provide "a guest_memfd". This is an early path-
> > finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
> > guests on x86 and arm64. I'm planning to build a memory-based file
> > system which gives files for both guest_memfd as well as memory-based
> > storage to allow things like userspace VM and orchestrator state
> > to be passed over KHO/kexec.
> >=20
>=20
> Thanks for raising this, good to know that there is more interest!
>=20
> Vishal and I have been working on guest_memfd with HugeTLB for a while
> now. I'll be restarting upstream work on HugeTLB after the conversions
> series merges.
>=20
> Vishal, Frank and I brought up having guest_memfd with HugeTLB with
> VM_PFNMAP mappings at a guest_memfd biweekly meeting a while ago. The
> consensus was that guest_memfd HugeTLB must support GUP and so VM_PFNMAP
> can't be the only way that guest_memfd supports HugeTLB.
>=20
> Your proposal is true non-page-struct memory, which has been on the
> discussion guest_memfd biweekly discussion backlog for a while
> now. Google is definitely also interested in this.
>=20
> Frank also described some use cases [1] other than HugeTLB and the
> regular PAGE_SIZE pages from the buddy that is currently supported.
>=20
> I submitted a proposal for LPC 2026 to discuss the interface. What I had
> in mind was to have the KVM_GUEST_MEMFD_CREATE ioctl take a "template"
> fd. guest_memfd will then read off what it needs from the "template" fd
> (ops, like you have here), and the "template" fd could be VFIO [2] or
> HugeTLB.
>=20
> You have a provider_fd =3D open("/dev/gmem_provider"), how about passing
> that provider_fd to guest_memfd, where /dev/gmem_provider could
> represent the page-less memory, like:
>=20
> =C2=A0 ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE, provider_fd);
>=20
> It would be cool if the fallback could be set up flexibly, like:
>=20
> =C2=A0 ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [provider_fd, fallback_provide=
r_fd, ...]);
>=20
> I think guest_memfd should be the wrapper around other memory providers
> because then the CoCo shared/private logic and special page table
> handling for both host and stage 2 page tables is centralized in
> guest_memfd, and also, KVM doesn't have to understand other, different
> kinds of fds other than guest_memfd.

Yeah. My approach was to make those "other kinds of fds" essentially
the same =E2=80=94 they are "a guest_memfd", and KVM didn't have to underst=
and
anything else (after a little bit of rework to have the generic ops so
that other code can create its own guest_memfds). As opposed to the
approach in Xu Yilun's TDISP series, which did teach KVM about a new
kind of memslot.

Likewise, I used dma-buf so that IOMMUFD didn't have to understand
anything new either.

I like your approach, inverting the wrapping of guest_memfd/dma-buf.
The provider then gives a plain dma-buf (not associated with any KVM as
it is in my current code). Userspace can use that *directly* with the
IOMMU, and passes it to your KVM_GUEST_MEMFD_CREATE in order to get a
guest_memfd for use with a given KVM. I think a lot of the warts in my
series fall away if we do it that way round.

I'll have a go at reworking it that way round... and see what different
warts it ends up with. The interesting part will be getting actual PFNs
out of the dma-buf (which is already under active discussion).

I'm not sure I understand the 'fallback provider' part. If one provider
doesn't have a page for a given address, KVM would iterate over them
all until it finds one that does? Is that about falling back from one
THP pool to another? Is this something that the generic KVM code needs
to know about, or could it be handled *within* a provider, which can
chain to the next pool if it can't find a page? Wouldn't we want that
done transparently for both KVM and IOMMU consumers?



>=20
> [1] https://lore.kernel.org/all/CAPTztWajm_JLpp9BjRcX=3Dh72r25ELrXeGkOXVa=
chybBxLJGS=3Dg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=
=3DD8ky94SCsw@mail.gmail.com/
>=20
> > This series lifts guest_memfd's operations into a small ops struct and
> > converts KVM's own gmem to use it, so it becomes one implementation
> > among peers rather than the only game in town.=C2=A0 It also adapts the
> > SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
> > guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
> > provider->KVM revocation primitive that makes overcommit-style reclaim
> > possible.
> >=20
> > It's largely AI-built at the moment. My main design concerns are around
> > how we tell that a given file is "a guest_memfd", and how we plug into
> > IOMMUFD. Presenting a dma-buf was the less intrusive choice because tha=
t
> > path already has support for taking pages away, but I'm less convinced
> > that it's the cleaner choice in the long term.
> >=20
>=20
> IIUC from this series, you're creating a dmabuf fd out of a guest_memfd,
> what does "taking pages away" mean, in this case, from where/who?

Taken away from the guest. Ballooning pages out, either for traditional
memory overcommit, or for the models where a guest donates some of its
pages to the system to run a "child" which is properly isolated from
the guest.

The physical page is reclaimed and needs to be taken out of the KVM and
IOMMU stage2 mappings. If KVM wants to touch it again it must call the
provider to get a new PFN for that range. This is roughly equivalent to
the MMU notifier path on userspace VMAs in the normal memslot case.
IOMMUFD has no equivalent of that for userspace addresses =E2=80=94
IOMMU_IOAS_MAP pins the pages so they *can't* go away, which is why I
used dma-buf for the IOMMUFD interface.

I've actually been fleshing out the overcommit path a bit more,
experimenting with adding async-pf support to guest_memfd in=20
https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff;h=3D894=
dd0fcb34
(the sample provider just pretends its pages are slow to populate, so
the guest gets to run something else while a "reclaimed" page comes
back).

--=-LbQdAGc+FXJ85CtJAqQg
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
m97opddSMEXhZVuxnhBjupwAAAAAAAA=


--=-LbQdAGc+FXJ85CtJAqQg--
